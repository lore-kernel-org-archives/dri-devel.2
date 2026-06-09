Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8940BCD8CAC
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 07:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F96410E125;
	Tue,  9 Jun 2026 07:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ocXp2s8T";
	dkim-atps=neutral
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E84810E038
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 01:50:29 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id
 d75a77b69052e-5176bbb9384so50738061cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 18:50:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780969828; cv=none;
 d=google.com; s=arc-20240605;
 b=PHf/Kis2bnnZ4sd8bG2se00ONQB7+bXkjaIdrpe955GRzOz77K/F94dH9MKGJWmOQz
 GolcyIwT1YlEzoZ1JdK7tognSk2+TGTiTnPwXB922/wFPXa6NHOezOEcz8y8RXy9uqVb
 tI8E5UYNmkmIMGWLVZk+pTrtuhR/1YxV0o3jKZkZQGQnVm5pH3TYnWomV9cKsuarsfXv
 gXRYZbgvRIzjWYYHoUm1MB0xi564Mtwmqn/MxxlXFL5E24UJjTPcGN50I/7wV9dvhyUL
 ALso+HtwKTeTttQI7DL8fucHHYPJVGqX2vbf8bnx6kZ/Mv7ereW318zx9TVVa2IfBrb3
 4CGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9+dm8iyl1FFmimzn8mWDuy0qsUo+/kaFvq9DAaWHktc=;
 fh=s1f85g8jkDccZ/un6aTfmVjm3/hGQg4yZb3YRvgk1yA=;
 b=ECiDB3MPTz05zszwdVBAQW3g++BUE8oynLHtgartxFeU9slo7P30DpibwCqeiFNaJq
 Cy5H3T635snRdmJ+6zs7eg0N6jdMzcefqm+qcHxAKBbU3SAxkUVR/Uc3qWw4xw7SMeRO
 /fsbj+SBAUX17JurbWLsP1hvnusZgRZ5FIr6UOJMl9ZEwy2il9E7QRJXP5c3/PR/Es8y
 zVj54EkQ4aIjEdUa9NJeNaIJExmB1hIgPS5h5s09EOZrgd8RP4tOwp4L/qp0Qn9zKNST
 WsiUGnzNH+id2nktJUeNXzBSlTqgLecXHg01UOX4vxQsiVZG1K5ZRSf75/0SHPjF9eig
 qewg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780969828; x=1781574628; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+dm8iyl1FFmimzn8mWDuy0qsUo+/kaFvq9DAaWHktc=;
 b=ocXp2s8TprMgo0ijjLLecBfhcPCIcNiSbUisvkjTuVCXqx5flSRLAciMWEV5fAHCCA
 9MKkvHQCq/hxdfEdQwFZlv6a4O3KXYSoGzs9Zi3TYEbJ8WTEvRVHJgXfqLxLOAQ//NtC
 I8YLvFZ+DmrhXwZde5PwWC/g2m4OQC0Ohspdt8XOby/0TQnoSVZtY20N3MrSjD51iJ2U
 R8VAQywMmXECtQKeXFhbfjI4AWQXxRjLwrx6JtqmDoSP/BNI0j7J1bEjxMSx/PXHJFLt
 UeA3htsLv2M28TkdF2/ZhjEHSL7dD6fcrbCHm/Z5cYTOVlGyPid86RhwCT+Y9INKjYOP
 eMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780969828; x=1781574628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9+dm8iyl1FFmimzn8mWDuy0qsUo+/kaFvq9DAaWHktc=;
 b=QKKqKIJOyEhsYkJSki2ETXfskI2uhVDLjnSbIrVT4gw8r6f/LvGqmTDr8A/mxVljzG
 GxPvOSth0EIAqh7LTD7G5A6EDzYrTeCKAVaOPrETDriipTcaRvTfR4pZiUwe/BPkaXZl
 LrhrafCoQh/+457RLIRtiNhVkcOh+m3mDODGD2V307KAg9aAJxTrgtrAPn7MNisl5l6B
 B/cis69oiIgZdNL77sxkGMY9tfnQ6+/4d5V/qgDdRmXjtUuc+9PGKuGFJjqDFBZnbQU2
 6uLDn4hizc2zlh9O/L6XRz914oncsB/ttkEdqhbBClAEYgtNuaCAyDZ7gzdkXXQhwGC1
 4WrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Z37zHlkn9ruIZ4621RWgteqgLELx7h26d32RKP/tQ1JmbxuK29j9aZZwYH9iwsCmTb2/hkBYPqaU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyS67oHW3b6S8pNUPZdBt3FslJ+n5bFX8Toe9sRONyv+Sfaeaqr
 gZ79Nz50dCdHsvfvaHo+vFtRacigyWs5c/q8ioG6+oKuzLt3ASWwUpAd1SFdE29DOiUjuxdPRA6
 GgZW9GayQ08oy8uBcsKtWaDHoilZObP4=
X-Gm-Gg: Acq92OF1HkSV6m6NvFPnjXOcPj1SSWbfpfRK2NTdgaW0yFMx2JQM7/iYCnzsv1ewni0
 N0DscsQl1p8Te+cvDwoosUrL1iU6jb62xEC66zuxQ7u6LXh3ENRISjTt70Q0+vWLnVN8JuwKmVr
 R+kVzz9AJN3bK2FiWMt+qRz2ovetv9ErkkkFO45i5pth1OkN4iI344PC4FteUnkHCmkf1a6BFIT
 gqf2nYj3fuQ3pBwnHbJldEIBV8IzpqnHrwAY56zs/LNYwi55Shg9BCxTaw3xtFHo3te18+rYQLI
 sVALZs+wZgZc8eOoGBjogbcEdTw33QFgSIls0LCkkfBI3MwnfJzq9cAwNkHU7YuOvQEqgohwJ/e
 IGGQ=
X-Received: by 2002:a05:622a:1b09:b0:50e:631c:c390 with SMTP id
 d75a77b69052e-51795c5be37mr269805601cf.44.1780969828323; Mon, 08 Jun 2026
 18:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260607210203.229613-1-deller@gmx.de>
 <b80a379d-87e4-45c4-a078-09e84a840895@suse.de>
 <1492766a-c349-4cca-932e-bf608b922b6b@gmx.de>
 <CADkSEUg948W-XT3_ODe_6p4i5Y8AKEcP=rmJ+7qJq30Uq0d_EQ@mail.gmail.com>
 <aiclYUfQvMokMu64@carbonx1>
In-Reply-To: <aiclYUfQvMokMu64@carbonx1>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 8 Jun 2026 18:50:17 -0700
X-Gm-Features: AVVi8CclBz3tJGvpm6QTFFfs_QYSfEhhbHcxbqfMUuBKjZ3-CDGVL-ri5mElbOA
Message-ID: <CADkSEUiU07XkMkvoyTTxn0VXprKok5tKj80fFnc4k=JHeK8FvQ@mail.gmail.com>
Subject: Re: [PATCH] lib/fonts: Avoid unncessary 64-bit math in font code
To: Helge Deller <deller@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 09 Jun 2026 07:16:14 +0000
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

Hi, Helge,

On Mon, Jun 8, 2026 at 1:26=E2=80=AFPM Helge Deller <deller@kernel.org> wro=
te:
> Does this patch fix the issue then?

Yes, it does. I remember you suggested this solution a while ago. Thank you=
.

Ethan
