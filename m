Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01609606A331
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wjeVOlGW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A3D810E13F;
	Tue,  3 Nov 2026 00:07:54 +0000 (UTC)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E24910E13F
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 00:07:47 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-18cdcfc05ffso4295410c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 16:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793664467; x=1794269267; darn=lists.freedesktop.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TvykTUk4R7T/uqrKjXDjIuLrA+PfKRZ6+JNOrXkof4M=;
 b=wjeVOlGWbJ61lcrLPm+6in2vdrxKhwIBBrzSA6s/bD38hiQoPFUXrB7Pn8nSIKMGWm
 Dv3ekQu9nASG9x09KbOBwl73ky9byKTJXbvVntFQGirpFSBsHNJGGm+olvtyRpU2AetE
 KY2gFUF4xrfXEEd7KW0G+Vkn59vS9acY5ddUpL4yB0kSM7LzPEaGgq7y4zfAp3iXSRXx
 MTowta1tnyXOm+azMy9Na8/3hVp6xHKYATRR7MvCnUu/PeJcopQ5wqcUQVoujjxIsKQt
 yFz89AZ8hz8WIpMzBc6hu8JV+lh+wx2v9XynaqF5WAFZiNR1UyIsRcCMyGrVq0yScKVn
 wWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793664467; x=1794269267;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TvykTUk4R7T/uqrKjXDjIuLrA+PfKRZ6+JNOrXkof4M=;
 b=cp0l07NHD9IuY1xd0jbmt/iG0c4o5EncDDW2+wbXzrzSdMcCbis9A81nAvbOanjsmL
 LBr5O0ZjAWbv4/9RnlweAKh8xSsxj/RF9c+Wq/nL6gR0FFhOqp8eQycrgDPLamfZcd3/
 0EdsC5rn9vunYUTyIVhAnBhi4UsylLwuGSR2IVGXVfycy5F2OvK1sX4EDwnBrKzjIPMn
 B8KI3CGtyHvmQTaU4e/PjkSImRH5wUlEos2+5NrW0C3cUnbwOyeV0hETAowpM5BnO5jQ
 LDQUmRbEQ5DVspmGl0g0JcIOYEeOxmXI4VP5Av5zOUM1njtsZSXbf2+9eu+Kd/mC4K0E
 GhhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxf5LO3B4M09odLV+Ixlq0CgEyOV5OdU9wRbiENuiCQDKCl9TLyhfFFr/D/OhlVla/RwbbTRnY8H8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLPGNiBwunya7qPyogJneQce+KmBXKX3GUQHW3EoR0EcUsKygOl
 /YXaz+BXGYAX/BEhQYQakWewPVEA/xwx0nWMImYZISdx4StNF1byJZAK
X-Gm-Gg: AYBFou33TsjxKCq6CjzOW34GN6NQHF5f7Ydebag24GJbDVuk6ndwfKFzXdMotQktJ2Q
 qn7e7wZyq3SdUbp7OYjIl++b35oHwNGFIakrtDuLV9c8W7+1y2+c64/lEChJRmmHboEIR9JiVqf
 8plKSpnmICGRxatHITkUqfo06+bDFC3SRDR+Lx/GxmYR2KC7p+53wzb0NGlbT7TNxvlnaZCBq64
 wuISFKq7CA+gFcSvOKz7iPVMqVivpT2Z2z3hfrrvhdCM2yrLEIenc3DZehnel56Od0zUdaQ2htU
 D8svirK0tT0Tb0NwMOAo9Rl8xOtJpNEAYXQnZf+gGCf1bIStaDjFuVoQA0DKU0Uz0tUzefrH4VH
 qtsA2Q6HpNmnT0fKfqsuCjaX18e77bhvGkrhhD2cK8S1cDacC5cLqxA2QxunVEdtpuwwUwrjgoa
 Zrbq/W9NYkW6QqVc3TAGKNWcZvoomWEsB0Yn+hXnVifut+KiqNVdwKPhUFhwnt+Nk61k573wYHj
 rwMcw9UWoPWvbQldIHRRF07RNo7qovqxv5FFZEg9d/MIAlXTxiturBnBkWTP286UtHzqHUrPxy/
 zA8g7+ub7qL7kPVYP2c3BOa1Lr4s9RA6TgA=
X-Received: by 2002:a05:7022:92b:b0:19a:8e3e:530e with SMTP id
 a92af1059eb24-1ac5bda7dd8mr22231405c88.8.1793664466566; 
 Mon, 02 Nov 2026 16:07:46 -0800 (PST)
Received: from smtpclient.apple ([5.34.220.141])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac192c27cdsm63335030c88.10.2026.11.02.16.07.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Nov 2026 16:07:46 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH] staging: fbtft: fix space prohibited before that close
 parenthesis
From: Eric Lee <eric.lee0305@gmail.com>
In-Reply-To: <CAHp75VcvKkOmFTtJDHuKCNVUMXgjZLiNqmGcHFKT__dtTt_QJg@mail.gmail.com>
Date: Tue, 3 Nov 2026 08:07:31 +0800
Cc: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D7B3C1FA-32F4-4771-BC2D-F97D07CBFFE5@gmail.com>
References: <20261031042315.1122699-1-eric.lee0305@gmail.com>
 <CAHp75VcvKkOmFTtJDHuKCNVUMXgjZLiNqmGcHFKT__dtTt_QJg@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Nov 3, 2026, at 04:44, Andy Shevchenko <andy.shevchenko@gmail.com> =
wrote:
>=20
> It's not a fix, it does not fix anything.
> Also study the mailing list archive (lore.kernel.org) to see what
> happened to the similar patches in the past.

Thanks for your feedback. I did check the mailing list archive for the =
same
Checkpatch error in staging/fbtft.

They either removed the extra space between =E2=80=98,=E2=80=99 and =
=E2=80=98)=E2=80=99 that caused another
checkpatch error =E2=80=9Cspace required after that =E2=80=98,=E2=80=99=E2=
=80=9D,
or removed both =E2=80=98,=E2=80=99 and extra space before =E2=80=98)=E2=80=
=99 that caused build error.

The key difference in my change here is to make that argument =
=E2=80=9Cmodifier=E2=80=9D as
variable argument, not a positional argument anymore. After that, I =
could
safely remove both =E2=80=98,=E2=80=99 and extra space before  =E2=80=98)=E2=
=80=99, without further checkpatch
error.

It passed my build and verificaton based on the file "fbtft-bus.i=E2=80=9D=
.

It is fine for me if you think that it is not worth removing that =
checkpatch error.

--
Best Regard,
Eric LI=
