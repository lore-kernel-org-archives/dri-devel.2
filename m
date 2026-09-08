Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA2BC79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D2910EC73;
	Tue,  8 Sep 2026 14:49:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=darkrefraction-com.20251104.gappssmtp.com header.i=@darkrefraction-com.20251104.gappssmtp.com header.b="CPpGGYHo";
	dkim-atps=neutral
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC52D10EC75
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 14:49:00 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-5c7d4c663e9so3523963e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 07:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788878939; cv=none;
 d=google.com; s=arc-20260327;
 b=nvTTOtIJn21k8XSdIdtdtysPnfPAjoO+FaWYJB1C6J2UT632CY9ZfgcUIVW3tW37HE
 fAbapxSVFSMX5DudWWAwT4+3vVicG3S7N4nb78iQv+dDPkfcnfVqZkDBNuNNorRLSF3t
 N+w+k5MLhpz6ddzYHyJxlwb/Q03VnSCI+7ccHmVoPi6JOSpZkLNiBDbNhgn6uR0e7JZ0
 FOUKADMeVMc62Petl0ZVWBijEvQ+gWbJRWE2IOFd6Xcbmlbd6kridJaxZF7JXGQUbb77
 weeBo72a5YLvrzVlqPkxVX/xsDiel2Z4/AURMx+3yCm47neMssx/WddDD/HKdwgJqJtF
 /mGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Mn26V6U9AHVIB3sm1/v6lJDDiA+oJxKcvjPFvuodVsA=;
 fh=J0cKCHdFqsyhd3/l6aHRpTw2XDcbMi2Me8HtL2pXskA=;
 b=c2gEr2XJrbYvcIqm4rrJ31bn6a9p2Iz52N5E8gX7XrsJ0fUqBK79odSfNrVpKcLodD
 NGbijR3jjByVe0qVZsjhh2wK4xh7uQsSV3AuWiAMwZ+kzhoar37jR0mWogj519y4Afbj
 Nxw8z0I0nns72DD06WDnuYV1LLnDhtpZvcbubuRa4DnmF8THXtXpqz03L1IWHUJ5vnja
 1/OCaTKzgxWsDZcR7UFlGQKd3b2xgX+jtUZ6fP84CQd0HkSNopFodhu2jYq/dmcDEH+5
 Sz7wtqotxulKSuZu1lsKYbdkapc8YfPUn/AzIg9ByTIl1lTXpS9xCdrU3tFivQt4Xw80
 rv3w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=darkrefraction-com.20251104.gappssmtp.com; s=20251104; t=1788878939;
 x=1789483739; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mn26V6U9AHVIB3sm1/v6lJDDiA+oJxKcvjPFvuodVsA=;
 b=CPpGGYHoaebiiZA2QeDAirvoVxsjMcgxzZgCHxEGLb4sXcKnLaIA9RVw034ScTlbwj
 DNdy3DCPZk8gzVbNml3i/4K3na1sapllLIXZeq3JQ67IjE5WRoNw6urNu4xV2TV44pdw
 WA/xb9QxQy/sVzc/Q69AZTpfIqIn/YDlUuk3oaWonQzBWC0r/LzneiRru6VX8BpLnJuC
 iHaKm1sT9MFUXlvJabDVsZ/Y+fZHnxztok3BFFBbYbUMk3Hfu2aV34CPiA/0BQI8MLIe
 uDJ1X2yKBAVjMd+Xr5FvuZ7wibQWO/fjI4pvZfMA7qTi05oN0Sz8IpChP5OjMsmk31HJ
 6dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788878939; x=1789483739;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mn26V6U9AHVIB3sm1/v6lJDDiA+oJxKcvjPFvuodVsA=;
 b=Z7zm+ctHiTc4HUiS4HgYIl6TNDv3xFewaRg0ERoJj8YF0jpTYvPhxXRXqs84UIOMn+
 PJlgqY25+ei3QgYA9jbKffT+dO3LakdRiUIaH80fkZxm4Qk7WJUrPgx44Siq372JBTKY
 yG4rzdL/kEId6YpvuyZLXGdabTjcGth2Dm1MWdhKHZPp5S7Smv8ttAozSY+GiZBVcPdz
 zdJ9Iq8YtfcN7ir4+4w6riVs9PYSoRwhtb3cPf3pEZI7M1yYlYfq6gRCyxxGbhIHnOaN
 DSuMHYjrUePE/FGqCScmt5QYHsgigNcI/t0/d0p4eK26n0WyL8JcqQLwaUk7WqwgcBDO
 AJzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxE4fQ8QxJxvTnyt2lcSqO201W+oAAzZi0ZfL7e7GWYZ6FYACp5iplLyybeoQFbZp8htmuiqPpF9rk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lVLLq83j9IGspeNtH1JILGdipd3hEt+BkbN9jHLf5TLmwDm7Cr
 ju1cm6KLsJtdl4hJSzQBnxuXOM1LWHPy3jUKUxjE3xWkLy5yj/HIe2v4l/ik8jLYbLcMlJ2vg6b
 v2RBKbLVMZ7I4WmayTLFIRMvmP5gb7F//3ajtpHEgeg==
X-Gm-Gg: AYBFou0dlqRjVfX3egnT06bszoozHn+XHdlFEkmy6ajDX+ce2QJaWOp8xWQh5wJH5sQ
 Yv+xUPPAMIN9TjtUGEczuOZLeL3L6BFHpYVWBRf9G3JjGsikisPdiq4FXAJWAdOmFvwbiakbNRa
 wSs+ufZ58wqyQ8WxNZPcFEcyeMZDiT/pOaU+NeTSKySSfxdrk3OcE7a6/jJJoIjbN4+sTo2dg6g
 fdi55t3KHAnabhLssACXu8pPqCs5Shgg2taPQQiQW1jtUkBUW0eihMgWtHjmWwzkjirPyZYnZEc
 jCBxKS3qDD7dy2Ab8Ipg0lh3t5oLlIvQ3RhUp/4YRYWD
X-Received: by 2002:ac5:ce1c:0:b0:5c7:ed31:3c11 with SMTP id
 71dfb90a1353d-5c7ed796b9amr13188562e0c.3.1788878939466; Tue, 08 Sep 2026
 07:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL3WXUPD5JKE.2GZ1CNJH539ID@kernel.org>
 <DL453EFS03T6.2VGI5TJEQ52QO@kernel.org>
 <apdvTgAp5eGezO5t@nvdebian.thelocal> <DL4QCAZXM8EU.2K8MLAM00VNTX@kernel.org>
 <apioGUDamrCur_oR@nvdebian.thelocal> <DL5MA26KZEF9.3KHKQXZ4JD2G6@kernel.org>
In-Reply-To: <DL5MA26KZEF9.3KHKQXZ4JD2G6@kernel.org>
From: M Henning <mhenning@darkrefraction.com>
Date: Tue, 8 Sep 2026 10:48:33 -0400
X-Gm-Features: AcwNN1VMoN6xdNn8eWXN2SwQNMCIT94e5yatQIWCSWj7WmgOlqVF8kOh6QLwKIs
Message-ID: <CAAgWFh2iPJzQ5PJfFpPBTdgZ=GFjy7Eoz5C0e1WwFMuOuyJSTQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alistair Popple <apopple@nvidia.com>, nova-gpu <nova-gpu@lists.linux.dev>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
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

On Thu, Sep 3, 2026 at 6:42=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
rote:
> Because userspace otherwise has to figure out the architecture itself bas=
ed on
> the chipid, while the kernel already did derive this information.
>
> There's many ways userspace could do this, and I don't want to incentivis=
e any
> of them.
>
> For instance, you previously showed how userspace derives the SM value fr=
om the
> chipid with sm_for_chipset() in mesa with its own lookup table.
>
> Then in NAK (src/nouveau/compiler/nak/ir.rs), there's this code.
>
>         fn is_turing(&self) -> bool {
>             self.sm() >=3D 73 && self.sm() < 80
>         }
>
>         fn is_ampere(&self) -> bool {
>             self.sm() >=3D 80 && self.sm() < 89
>         }
>
>         fn is_ada(&self) -> bool {
>             self.sm() =3D=3D 89
>         }
>
>         #[allow(dead_code)]
>         fn is_hopper(&self) -> bool {
>             self.sm() >=3D 90 && self.sm() < 100
>         }
>
>         fn is_blackwell_a(&self) -> bool {
>             self.sm() >=3D 100 && self.sm() < 110
>         }
>
>         fn is_blackwell_b(&self) -> bool {
>             self.sm() >=3D 120 && self.sm() < 130
>         }
>
>         fn is_blackwell(&self) -> bool {
>             self.is_blackwell_a() || self.is_blackwell_b()
>         }
>
> That's two unnecessary indirections for something the kernel already has
> available.

Userspace mostly uses sm id and engine id for feature checks, and I'd
like to keep it that way. They correspond to either the shader isa or
which class methods are available, which are what it relevant for the
related code. Most of the checks don't look like those functions
you've pasted above. Most checks look something like `self.sm.sm() >=3D
86` or `info->cls_eng3d < MAXWELL_B`, which is to say that a
completely opaque enum isn't practical for our purposes. We typically
need to check if we're before or after the point where a specific
feature was added or removed.

> Yeah, although if SM is correctly reported by the GSP, I'd rather have it
> exported in an info structure than have userspace create its own lookup t=
able.

As others have stated, the sm ids reported by firmware don't always
match the sm ids documented in cuda-related materials. and nvk follows
the cuda conventions here.
