Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBD4CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 18:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69EF710E0C9;
	Mon, 25 May 2026 18:02:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tl+i5q5I";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 113DA10E0C9
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 18:02:32 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2f5ae07e2b5so797544eec.2
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 11:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779732151; cv=none;
 d=google.com; s=arc-20240605;
 b=Voy17VfIzppxdbYYqVM+uj+GECmwj7hJYoLhjbY/Osc8y7dwyn58RxjlEEPg+nO1hy
 NHQeZ6r50y4pzZcDfpsX5ONIqyH4x01driT42RG9kKMK/S5bAFIyj7+SCpN8YsOV70dq
 QLKGcfjVXwcvFq5uq8V5UNon05E+o+8WhTRLfK1GJkxOTLihUT4dKa/p7oOflie2ehFH
 Tz9+PsFp+GJQ5dWfNCBRBDCtzxkephDPf9XnFKny1KHjwIusFGQZ1iQV/RYfCWCg7LMz
 DDvrlYZoNPgxaPOE2BaH7+M3n3TmaXdaBwINiGTNtil7lHgttBRX67v8L9Ski+r73A3G
 gcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8ZSUnXluYLVn4jYwuGuuAoUqSSDCn0ar/92Y3HH//e0=;
 fh=sF21RXTl/t0FOcTEpBggLdJmze7PjCIA+LZSAiWx5pM=;
 b=DN4wYwZbJanwTi35RRwmk3uKiE/KaYGi3ubBPMKMKYcFhnD4bELrjV1qKvxCBcwmWR
 TYTMzDMHURqaH6Aqngusek7ESphUcFdivrsoYwPKXbgkwmphHLIL7I7ku6iR8ba2efTS
 2cCjZmwFbC9AOn9f+ouPiiRn+AUCvQc4X0eM26Yv7ly/uQ1H8vNdtsWGLRWn0+4sIljn
 hsTa9KKozMMk7D3V5qMQiwrRiFwBTseXnhuYy3cbjZy4MDLhqZDHkt3ZODySP1yG5vrt
 xym2tSQsCk8iZ8Nj3DmC2xVlTR/FEeY8r5HlfO4dG28lqeVNM8Wwusa9NvJj4TPS8ucs
 kJAg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779732151; x=1780336951; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ZSUnXluYLVn4jYwuGuuAoUqSSDCn0ar/92Y3HH//e0=;
 b=Tl+i5q5IZUWvNAeDWSzuwkn0R14zQPgGn/o8XmF/ZTNLTry2vTrWg7EhMGjjID4ktE
 0C8acGvYyIKSXRRyvxS5/5qH+NC4zZNPUTIUwb4f6leSLWfvQxciublvNoQx0UopPADK
 YslB1mUyJ3j6Re+x3BL+vdhypA1iercB8WaiYFlXRBPkUoIb7THN1CVYBQoarakxmH90
 IgGwVhsncM/aqOu0xMFlCkSjc5fgWm5W3jhV32KcqpwG3nI9DGuVMTuCAw4hcgR4I/bU
 ea8MqiM7pDKkyk5mCFVOJpfc+EGd6q1EMnNYJ00lthq56tdvUCywgCgTHXHJLZO/lkhx
 yQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779732151; x=1780336951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8ZSUnXluYLVn4jYwuGuuAoUqSSDCn0ar/92Y3HH//e0=;
 b=Uppc9jUZ0lnyLRbfde6FpefHu0hrVjz5bm5lqsPTiys+uVV8a5jh6hWn/eI6SvP8Kh
 9Wodc1V5xdw5GrDQuts40mnrCXWVY646lTQMhdESGAAp1F785hHlbsOMGkeQY+A3rKr0
 KHbEfG2Kz0uFZnljZtgwkuRNXNUQ+cx71nYDX0a3MN/N5zt+H7LQq7A2GpfenS/fwrzA
 oaTnZqN4XtfMxe7VzL1Wh0SGB5b44AU7w/Uko+vQBYu1byFA8rjA+FuABnRCC2n7OSij
 nvdKs/YQHnCKkwyccKIGCp+Uhw2AALa4dymVyuVaSdlrKQjClI7lZfGi1TGeTGFnRQS6
 SpgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tV2eel8hmr2g2Dxh5qgXhyMXCRB9Yvynd1C2h3Q7ViZ0w1klsoAbs3WUS9lIuMz6GcX9pbf5v1vw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmBXnLZewps5DD0jJHjTyk9U09lMZ3NAykUAu5IZKjhCJzIrlm
 /8NG85mVm+5AjYy3x5vW3Le9jjuZsEunzhK7K5W5YYID788N38WciPW5MJLoeu3aJNSJjvYSPHH
 4UZzj2IxvQmA4141/TmJldB/J+W+1Xcg=
X-Gm-Gg: Acq92OEMsWIrMxXwSX9RISbp8Dd6n1ZWeWlVtUDlD59QgYKEPXqbdm9WCsl9mqi+OUv
 irmtgQri6dZ8SUhos0e48k8dom8pEhcNSZhLwkzDvAsYnHyWPKOUPyqKSXYTyhU+j1TRW2LlPpj
 52mMgJsw+Rh9vufs+nw6gDFVuq9KWDGfMK/ipQ57h6akQQ2DB0lnBEDkp4N01p4/H05ilWR10Ce
 I6G7dBG4GjShR2ugibJpUw15IVoE4Y7TYCHTkZ3jNEj0fVpwXqEa/d6IM+NPlcFs5rKdksTC0Ya
 H50mZgSPYRygCG+me43eJgvcnG5pdOKkCrk2yMQ5mOhV9ifwXtw9JNiAWQWskoDW3PwAaAMT4ZP
 V80tfcIkG/29w0aDUZBwB4sM=
X-Received: by 2002:a05:7300:fd10:b0:304:1fb6:8903 with SMTP id
 5a478bee46e88-3044911cc33mr3366059eec.7.1779732151161; Mon, 25 May 2026
 11:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
 <20260525-fix-vbios-v5-15-e5e455251537@nvidia.com>
 <DIRU7Z3NH9J2.2HT7Z93HFCFW0@kernel.org>
In-Reply-To: <DIRU7Z3NH9J2.2HT7Z93HFCFW0@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 May 2026 20:02:18 +0200
X-Gm-Features: AVHnY4KrDhM9kXsLM911_pGuZ_nGXHEjBgcjbdN5ENiTRugzSuQvUMPiVBLF30A
Message-ID: <CANiq72kR0raSG33DgSxMuc-2uMa626dT=-5=ko_HBgmeOrCFZA@mail.gmail.com>
Subject: Re: [PATCH v5 15/22] gpu: nova-core: vbios: use the first PCI-AT image
To: Danilo Krummrich <dakr@kernel.org>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Mon, May 25, 2026 at 4:46=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> However, I'm not exactly sure it really is an improvement in terms of
> readability and whether this is a prime example for this lint.

The lint is globally allowed since v7.1-rc3, commit 838d852da850
("rust: allow `clippy::collapsible_match` globally"), so please feel
free to ignore it.

(Same for `clippy::collapsible_if`.)

Cheers,
Miguel
