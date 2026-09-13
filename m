Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1CDC88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 14:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6975410E134;
	Sun, 13 Sep 2026 14:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mKlvqGyz";
	dkim-atps=neutral
Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com
 [74.125.231.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0A310E134
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 14:55:02 +0000 (UTC)
Received: by mail-oi2-f13.google.com with SMTP id
 5614622812f47-4b37a3ed714so673284b6e.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 07:55:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789311301; cv=none;
 d=google.com; s=arc-20260327;
 b=BORWJSNpX5ByR64dZGld3iZFuLsnRAPDgXyhwExjtIfcHQlmDalpXcUki0rgBpcYRC
 IuN+f/fnykvPPeTXcTaZb2gxIcEmmiJvc3yb9+yoU66QxMujj70IjyM31uxmwdANcjiR
 XWv/ypnQyjnjHFq4Z2iW/KFdmRMaNC0WI/U7whkV+BxTpbCh3LbtfdZv5PoosAy8f1kC
 leytHfCfiEuQC7NH+22676PxnVwJtbUnCY6kBnblimX63fkPVN+WVNzUYPZxANsvprzl
 so9U4AFWRvvcTa/tUNulqZHGp6H4Q8Ea008+KN5Lv6f69b5H/JPtQ/ubmH9lV6WJGLOn
 rCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zdUN+QWwa8fyRs0dHBEhiU+fM2pLoHcOi5IEgZOWjak=;
 fh=339h3dIXlLVdyHehyhOtf9aDFOr31TBy8c1HnfdA008=;
 b=IAKs6sXa/C2ljQ6jufUEIqfnLmbzsbzQFtdUlje+x707jz2o8Ryzkafp74n0r60Sp8
 /B3g3+xa4OotsT0vnkERRGj1aYfIXuw1TrtG4GcgbUUjEMCIF5WI3Ah1hla9/Z0AVAq6
 4oW80BNAsF27Hsx9KufqYyZEJI9Mp0wl4BmaY/SWs6uMPo9hPejO6fkJvheC/nnaUN0p
 gmJYOjOFjh5525FZhFeggnGjaooc0fKOiEckpeVzYygdm4tHmxEbVf8XXGi1qi9jqy4F
 RSLDSRhqQiXI0F2AefxlMD91b1KEauV+xGLKa0LT6XMARzlAdH3axHkrY2wR6L7nmmVI
 zQzg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789311301; x=1789916101; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zdUN+QWwa8fyRs0dHBEhiU+fM2pLoHcOi5IEgZOWjak=;
 b=mKlvqGyzI7xTeJ9HzJyv2YHWrl68fAtHZcxXOQe561eXKy/N8qG3TgyI+M/WefKJG6
 cRBWrdW8v+WW2ilvgO04K1bXMH+xCdoEWvlHhdpP7p+gtAct3ys5sGkIGOLGyxiyIwRk
 it+IZE7q1ZM2zlbB4fSK83yd7HSUgwI1mUHxeKo7P47/THz1vsNSXxJXcNEo4iGJt4T2
 tY7Ph5tbKVpZ8wC2syslUXRDqljPVc2XsF2EcHyUbMAhZsBy/Z94xkBvGJk4Xmqbr2su
 ej/YyFlLl+qTSRSHaopjY/34ZWuGif4KIaplSk9QddEMSbv9XNi79x4DN9AypcSTE+UV
 DtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789311301; x=1789916101;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zdUN+QWwa8fyRs0dHBEhiU+fM2pLoHcOi5IEgZOWjak=;
 b=Hr+NDR8JTBkaOJD4+BEBYLnf7XTw5FfzXLUw9vd0G9QnDtp/hMyED/V7tEsnOUnVHU
 Zi+DK4fRLlDiMp0wrLNzRxuWSqtpddKBBmXE4kyoc0tFgzlGs6VER13nf2EG4Sh+4BRQ
 l1wGktXCcRL8DTHn5OkOH+bs1k/7i3m9P08AhAcPohSLAznNdGOXpWvdDv4Q4ike795u
 jMjGj8nNEU5LacuQg9NxVim0YqgumkLcu/N/HIt9wZiWC6NbhiDY3ZA9r65/VX8WpscR
 iG7X+IWZYo/HDOcZYZ9czhYw/7pMlh/Wxufh7x3RtHYZdm57FdH2vnQcGWu8DZMQt9Rl
 4/bQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnm1zpe0NfUGFJFZ8RHGj0+2jU90FCRPD720SkUEyhoF75buI/YOb86h9AIc2lXgaJAtzsgxOJ1lI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nvYnCrVwtuLgCwNvhQb50Pxo+elrwP41i2t40xofkNtKle/V5k
 C0c1dK+MJHaFf/UxzMOpj5oKGbB+omKASkfhmQwd31FzXHx3uTPRIBsy7vsJceoJQppzJ47H11e
 bJHbN1VAFmH7aYiaudroVjGDGT/AA3O0=
X-Gm-Gg: AYBFou3kXbjQYpbyathGay31Mm6RS6B7US8Y+WMb68N54JIUxbxvEdubCPIXOsejb+f
 vHoFJIACg09DpFse8LFwJIOQZWOqE9qrCST3ujOopTc1DxfVfAhZij2GthErNeey2j26HXmUpVE
 ft2Dpe61zr7lMcSvV6Mcf1pOMU5Jf6k3FuqETLdipN6RIIzRpnziXJ5sDp+8nhT3ZVTwzxk8rcK
 w2htGcWIgoXGF8RI0xblFp3DO6xzvGffIHQLuxRUJqdBLsgG0NzGUFEzpF0cbziTvGAOSDOKjZ1
 FV6c3aTSIFANDD15d3B+mq2LY9XFMQGdgJPCuzFkXAbe4FjbShzOifGPkWeh859Si/vN+MALE98
 +0/UcOA5acglizQ==
X-Received: by 2002:a05:6820:2213:b0:6b2:69bf:c8d7 with SMTP id
 006d021491bc7-6c24c3c74ddmr3477590eaf.10.1789311301456; Sun, 13 Sep 2026
 07:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
 <20260823111959.17029-2-amit.barzilai22@gmail.com>
 <20260823112814.896AE1F000E9@smtp.kernel.org>
 <8733vhmk4p.fsf@ocarina.mail-host-address-is-not-set>
In-Reply-To: <8733vhmk4p.fsf@ocarina.mail-host-address-is-not-set>
From: Amit Barzilai <amit.barzilai22@gmail.com>
Date: Sun, 13 Sep 2026 17:54:49 +0300
X-Gm-Features: AcwNN1XXW1xsHHvqDyl6Kgqlf_EPuqEBtUOLVnrobbG5_xucG5tBFGj0BV3mYoM
Message-ID: <CAOEgbEqd6pGUL6o2CbyePUWm=NBy1GJJaOm+_7rg3CsEGqEfYw@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
To: Javier Martinez Canillas <javierm@redhat.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Sep 10, 2026 at 2:16=E2=80=AFPM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> sashiko-bot@kernel.org writes:
>
> >> +allOf:
> >> +  - $ref: solomon,ssd-common.yaml#
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - solomon,ssd1351
> >
> > [Severity: Low]
> > Should this properties block also declare default values for solomon,wi=
dth
> > and solomon,height?
> >
> > Other bindings that include solomon,ssd-common.yaml, such as
> > solomon,ssd133x.yaml, establish default geometry values for their speci=
fic
> > compatible strings in this block. Without these default values, device =
trees
> > that omit the width and height properties will lack a schema-defined de=
fault
> > geometry.
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823111959.=
17029-1-amit.barzilai22@gmail.com?part=3D1
> >
>
> I think Sashiko is correct here. Let's include the default values in the
> DT binding schema to be consistent to what is done in the other bindings.

I included them in v1, Krzysztof mentioned that they should be removed
since they are deducible from the compatible:
https://lore.kernel.org/dri-devel/20260611-psychedelic-funky-foxhound-a8e39=
d@quoll/

I personally agree with Krzysztof, but I won't die on this hill.
Let me know which way you'd like this to go.

--=20
Thanks,
Amit
