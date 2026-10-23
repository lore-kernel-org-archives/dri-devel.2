Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A340E606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hB9ToPYK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 114D9112B73;
	Fri, 23 Oct 2026 14:15:35 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EED10112B73
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 14:15:09 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-35ef6b49813so1327971eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792764909; cv=none;
 d=google.com; s=arc-20260327;
 b=aZXTIo+tIcwSU1fbWYSjXd/SNr1utPXmnhV2teu5th3cuCrOcWLUAzetEo66zRWSZ3
 9ciWso4RCLqoDMQbiPhTlr6Vu3sYgUW2ODUueSsj9hY9IZHfiXGjU0rfTJDsZ62HRx4z
 +KuekYIGkAbYjlcsRYwHgkGMHSBoAsAMw3Plygiuea6ppIr+Q1Z3aYzfrcnYUWLu1gxX
 S6GSCBQq+bX3H0xlI499ezIoKQa4ExCQoXGt/HdqXWtpaaZGh63IJK156ywEpEIjOs8y
 AF6jTRWx0OwgGnaO6WQjDBSJsBsSxzkdeoVmNmXp4pLmUMqslMKjqTpIkbEO9gKKuHKD
 sh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ssHEzjzfcY3y99EaZ6IT5t5Uq+N8qOcZuAF48Ej6bak=;
 fh=SIt0u9oGAArtvWVK1xScGr9EuJE52niMloLyZl8R8EQ=;
 b=Nk2X7m53t83fdZyCcfRVYN6lKRsyjj1Av8SKYcHPzz6KkPMkQg/2MxSWbwiWQ13Muz
 p105OtO2xb57eLc6EEUWVgCj0Z8puxzzjPMge29X2WX71BbFGgy9hyWLCSg+0ElxOHYL
 Fwa9co2GACV9Qsv9CRWlPE4M0KK48CFeXzrkqzqs12t+n5R4f9QKnN8dYrDn8jLaRENW
 ZvVmXsXtMLlwnt5r/F1K/cjGC8CTM5IW9T14XoAo64/l1DIMRFMzAiI6NYiRwxeGGPOR
 jX61e4wFSI6sB9MnlHm58z/19SqAV6H39fMVZwDG4OOwQMbmgn5RhTd9KX0CtQP1d3aD
 Re5w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792764909; x=1793369709; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ssHEzjzfcY3y99EaZ6IT5t5Uq+N8qOcZuAF48Ej6bak=;
 b=hB9ToPYKTN/YMlTSm0nT3f8gxfQDTIqjpZoonvs5Ntn5YmDTvAAm6ywAWlaFrf/9Bv
 lTDtuSRVmFoASxPgpP1gNeuCnrjby27F3cyG8V2cpJf98kJUG8zkfiTytTLZUMbI7MZW
 wQ7oPilqzxFJdzGg/77o3rD8uvgwIVMcei3ltHZPHr8OxQgxuiJZMF170d2jAQUfMuim
 D3LZbuTzm1hW+L2NZVdUAgRN/BtLQ32MfnhoOid/gAnQFFBJFRDn9cWbELAWpt+WONIO
 FDghYbLvtC9XPHZfUhqOem+FW7MkutcOhmKv0cds+v5w3RT3nfRJFp1JmaO1RkNBKen3
 Ly9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764909; x=1793369709;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ssHEzjzfcY3y99EaZ6IT5t5Uq+N8qOcZuAF48Ej6bak=;
 b=ZZzr5fendzKkZtU3Y7WZL5HfcMJz8yc1yGGCaRNsx2npkwgeuXRjxVplXc5YyX2ov0
 mkbCVQw4FCk+WZA1AkCpARWArtUc/bMggmQ0lZNosJsQkqQrP0OV6WAKzAQRidz4mkmd
 qPNXZKhQ73x78pvCia7quvTXEs6K4hOLDZ1HJ9QMJq7XAhrAxdfv/yqirYiDbqoaRVh7
 bEaQ9J4Bv7VFINebAC408DJh7d54a0S9DeUyjQmeK2ril71DdP+bVUH+5D1EfQX/9Ouo
 gc1Pq4akvu7IdgwzcFBXhl46XN1/fO2jDnQNGnQtmexHu2vXuHMuwwFFNR3FD1TnAJnB
 M13w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlsxl07Yu6lri7a48INH5mdQ7DxteFMnSgKEKjDwafoEOmW+emPNcSl8N7Sin+IpFLO99dmhURvLA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLy1uinDkHDn/miKPXpRobcp3BYS9/29KQpGMeOKSJW+c74WTDZ
 gOHhhr9bDNYsulGPbeZ7xJYT3Btq/cssSfbPW5IVzaScOKOYkKz2vBM7Sd9+aOpHFZJP2JfnPRn
 dGT4Ee7wPR/FFgqbfTApezoPZJU2NPiA=
X-Gm-Gg: AYBFou2L5ezqgOqjSDuAS0HnwEXxADiztZrfNfPQMUSAwTc0qeQE7DvVHnkX5sC/SF9
 Y7+zj0ohYomLmDlSs0N8BOs2eXj+4lymOvmhCKLJoOxuLrhkO34n1ewIfitDLoCDvnFc4qVG8/I
 7LiWF0QGkHVXhcW4SfpABKIStdRikR1eYmHvba6YbO7aDiyDIKpmjH3sJSfJw0Atw80oUdErNGx
 MIjtU9UGvUWNo1QzoTF5ht2Ij3PfAyuDSvKuesTm3K3As1+sVkIUsgSWLVNmZfyBLI2xuWO5AB7
 EMae9emk19NBgnuSoGh6UoTW/GobPj8UMxFcIQJH1bY5ejOoFvLgUCxWAJ0vWjxOjIlIBDeAjok
 e5dcYXT1+raSmY96rseESnCZOBSCgXyiaWW27+iOXVt2s7kl0WOb6ZRd/NV8I+yg3/wi+Bw==
X-Received: by 2002:a05:7301:6507:b0:358:8f02:e0ca with SMTP id
 5a478bee46e88-369d96e0ad5mr4018525eec.9.1792764908756; Fri, 23 Oct 2026
 07:15:08 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022132259.240717-1-clamor95@gmail.com>
 <20261022132259.240717-8-clamor95@gmail.com>
 <Ot5qxntOTJ2QgFh6uZ0riA@nvidia.com>
 <CAPVz0n3Vrzb96iR5ZW8zvmruZ4aK0hKGKpJ2T9Ys+bSPCtLWHw@mail.gmail.com>
In-Reply-To: <CAPVz0n3Vrzb96iR5ZW8zvmruZ4aK0hKGKpJ2T9Ys+bSPCtLWHw@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 23 Oct 2026 17:14:57 +0300
X-Gm-Features: AclHuK8iWdYJNcYZY57a5wy5nSa1L6Um7fXs3cPnETk89r87jtgd5ZLBghEmEmU
Message-ID: <CAPVz0n3gzV+gAu_gzp3oTG9VOu-YiNSiQA0SdCFApKsi0dGjKQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] drm/tegra: Add support for 8-bit CPU interface
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 23 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:2=
6 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D0=BF=D1=82, 23 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 10=
:53 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
...
> > > +MODULE_ALIAS("platform:tegra-dbi");
> > > +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> > > +MODULE_DESCRIPTION("Nvidia Tegra20/30 MIPI-DBI Type B driver");
> > > +MODULE_LICENSE("GPL");
> >
> > No separate platform driver or device. If a separate struct device is
> > needed for some technical purpose, we need to create a minimal separate
> > virtual device, but unless there is a strong reason to have that we
> > should be fine with just the dc device.
> >
> > Thank you
> > Mikko
> >
>
> ATM, I use bridge framework to describe interface and I am attaching
> it to RGB since it basically uses RGB to transfer video data. It works
> pretty nice so far.
>
> You propose to replicate how RGB works just for DBI?
>

One of the reasons I used separate pdev was to be able get mipi_dbi
from it using dev_get_drvdata() from patent (dbi bridge in this case).
DBI framework seems to not have a way to pass it in any other way,
unless you know smth I don't.
