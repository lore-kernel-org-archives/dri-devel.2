Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D63CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B5910ED93;
	Thu, 11 Jun 2026 08:51:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LM6b847t";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4C1A10ED93
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 08:51:26 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-304f9bc869aso947125eec.2
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 01:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781167886; cv=none;
 d=google.com; s=arc-20240605;
 b=ctljEMEUUY9mDvf84ieCHqftxJB7SFbpnG5lGL39g6AWbClfedb6yIghme4NOupay5
 rjO4fIekEN4gm5/ogcD2Qprq3fsOuz/lQ654rmDkae/47a5xUfwO6b/Qs521yT18WZ3S
 NprhMiuYOD5gj9ebMduvjc3bA0pcPJkB09qm1fwxhxW1jcSnF8P1ZKWtMdPd9iL19FSE
 v0hfXu9aFe1pwvep9EUnlBMfW02KF7jGkqCQTUPinnDgT5mRsOuSbYig9Wy0f+jUJFrY
 D4FXYeYBbn0hBcVFog6a+8uGaO31wFSz+wXYCLrXRgDTEw8KjPPNsT92bZ3qDARJsLbo
 Sx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Gu6SXLCI0/eC/AnJZSyIbfVO8bAqJ5On3y51xTlO4vw=;
 fh=fyhkBswkU5a8DLrVqe9jd+ZnasL+9PwkasBB8++90Gs=;
 b=JiX9C/Xc87wDqNHic32+i5UMBOQi7OdFD6nOwsMFK0k4NqU3RsVXvJZ8//yX16puWF
 kAW8G8r1+g005kns7SPcSbTx7gjA2j7RTy+HHATNmaxxMa+U8XjswVlYhUdvGclFWY0W
 qwXTX6zexi3XIBsvEVjRfHPmzDRRgLLBaw9ZCguuThM5eggTVrOHP/doc3bDOeHsoBCP
 mSd0iMWRXAfJ9VuFo+uJhT5ugsxa0LZx/R5rj7JibrTZN3QBHRv6IW6ahXAEgGvr2MeH
 1BQVaKaizTccrMfiADy6aVpWOgbR+rAVD1HeN1t9RuErihyu5F3D2dM29hnU/krTQODR
 CmOg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781167886; x=1781772686; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gu6SXLCI0/eC/AnJZSyIbfVO8bAqJ5On3y51xTlO4vw=;
 b=LM6b847t+Vxt44TXezJL1equECBA35uxl1wkJ3SReIUp4eohp0MZG5EFyKPwaHCx6U
 rIAo/8HodCcxQl4cljsSG00QJH8ogQ8X2KA/hUuF65K3tCPtzMfJE/E4FTNHGj8oBwlM
 ZG3WaGP/A+YVTYk9S8eBtKkgZfpbQxE6w0skE8wAgX+mFUzA+L++rEq19XUwAG/mUxTJ
 PmqU3uhsC88+D+8TFwhFXDs66AmVHpWhMgNme/qwKM1F2m+82mTEePhMvQXnY0gIPk1m
 QF7hdNKU8hmp3MRK2zwp7tMPXAOPk5gWto7FtvrYzvQiipdSAZ4oONbPj8sd+aciBPR/
 YQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781167886; x=1781772686;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gu6SXLCI0/eC/AnJZSyIbfVO8bAqJ5On3y51xTlO4vw=;
 b=WgLDxUWBnSB/gwv0ZK9mP+BhSd4ULZkYOzys4Cpxs02Pt5pXPdpZbObSBoqyfuORYJ
 K1ont2avnDlDtuuAlBZk2shwLRcplQhWrbI24yFXw4JUSsBJj1Ge9PZYrlgP4tH02RLz
 RcdLT6B+2Ky1Ng5JSN/Vo7sda/dQo3rB5NuhG1Eoy8hdXweaaFU/mMP8vkqli0mn+Akl
 Td7xX9Tp0Jmq0r4I+a+MSichowJNTjqhoKoziN/wpVEBS5aoG/2c8ENnsOMaPavOo4ko
 sKSSjr8DNLfBUKOeGyBx+YZ7ddKqgHVlt6K4X3ffl8bgLTWYyYl7SspiZBuBqSbrqil3
 fzlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9SdETRh3kmj6XxUumHEgCvyqt4V6QulA/fZsIwb/OTJk6OGjjrG7G8+ONJRjSfwqDbi49p5hNR50=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwU7VDdcNOjeDtSuens+rDig2NC0wTO1P6/IgDHZeVS33OqeGjZ
 K+uT2QF5wIr/GcZQK/SCP5E53BDnsw0HBs+WT7pTyDtUqdBTku/rfrdtjf+ogfT6NwoG5i9wweB
 RkYTCSDEh59W8rYzUscmV5ddNLB2Sxkk=
X-Gm-Gg: Acq92OF7GVIJRn7On4VJIIT/Pna+2CthNCbCDMix1dYMScBWWUt65bW5IpcR3RealBv
 dTqqZIs/30kBINDaKmYrHWUGFolN3oKIe96AY0jjcyPqEqLU3I3HkX57EzGvAv5rbMN1JnfZg1j
 j6bzCsnYTjdblS2wIHBHpcq0h3AzA4dF6ph9Z8Q1H84i57ViImgUx0wn46Haq9ViMlf/5wuO6bO
 Hy3+Lc5g6RynoDHto60Hdi/8OTkveCusau80OVRUc2ukGQjXyOtd6K8RnRNdN78l/bYJr/Id5X5
 5hzXKVg/31zE0q5LejmqaTw9j6BDnTKltf5+WdgWCDFJHhFCrYWKskOQLyWcE1L09E4uYCesGPI
 FaqjbRs1FRFIZ+lM2IUuOxFuA7gDWeO3b3Q==
X-Received: by 2002:a05:7300:8184:b0:2da:b05a:5a7d with SMTP id
 5a478bee46e88-3080410050emr652555eec.0.1781167885763; Thu, 11 Jun 2026
 01:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <DJ4Q5J5OILOX.1KCPFIVUFN2VV@garyguo.net>
 <20260610072947.338278-1-ojeda@kernel.org>
 <DJ5A6AM2FDGQ.19T1Y9N1T6JST@garyguo.net>
In-Reply-To: <DJ5A6AM2FDGQ.19T1Y9N1T6JST@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 11 Jun 2026 10:51:12 +0200
X-Gm-Features: AVVi8CeZqdEWXPdGh8thUTK4-wo6B8DARvooPGXEOY6tr17NX-f1ZHtJHf1zMrU
Message-ID: <CANiq72khOCLC5kG5vWhDeXpHv6n7Yo9Nv=PewNS0D73AxUDB4Q@mail.gmail.com>
Subject: Re: [PATCH v4] rust: make `build_assert` module the home of related
 macros
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org, acourbot@nvidia.com,
 airlied@gmail.com, aliceryhl@google.com, bjorn3_gh@protonmail.com, 
 boqun@kernel.org, dakr@kernel.org, daniel.almeida@collabora.com, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org, longman@redhat.com, 
 lossin@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
 netdev@vger.kernel.org, nova-gpu@lists.linux.dev, peterz@infradead.org, 
 rust-for-linux@vger.kernel.org, simona@ffwll.ch, tamird@kernel.org, 
 tmgross@umich.edu, will@kernel.org, yury.norov@gmail.com
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

On Wed, Jun 10, 2026 at 2:28=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I think if the re-export is of form "use crate::build_assert::*" then it =
will
> still be the same semantics but would be appearing now?

If you mean a glob import (within or outside the existing `use` --
same behavior), then that makes the glob import appear in the list at
least, which is an improvement because at least people have a link to
the module (i.e. but not the individual ones).

Or do you mean something else?

Good first issue?

Cheers,
Miguel
