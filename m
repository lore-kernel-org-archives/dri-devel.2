Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CE6EA3C21
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5744E10E747;
	Thu,  9 Apr 2026 09:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="WGwtQzZp";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57BA610E747
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 09:59:43 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5a2a70bb66aso765994e87.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 02:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775728782; cv=none;
 d=google.com; s=arc-20240605;
 b=aa5Iz8V+o0ae9ksAXx2WR7aV0sSEWwqiSu1B+QaMK6RRfrju0e4iLaHlC9Q5ZI8mgn
 TEVWNftR8QrH9Wy6jnkOUHhLsG721Rn6HxztINHIwfvMrWYPJxyFcVnLESi9tntQoHQ/
 JLBdqUF3uDIyVP2VTQcg7r1zzXFsdajihqw8B0LuBT5oNOTSkxRwjpo+2vUVcYnJMX5G
 mNlTWq0lHlQW79KkwCfw5PGo1u2FpEkVAmNGUMpv2D5k5CCnvP6eTtbtZenpJkqys3IH
 6awH/V+6q8vPFAfVu8M9OGzUHjGbonVLQ+LjuATRO2CMggToX4GRNdG9l9xO1fNMz50T
 dO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jt+KgaptQwnbiIvGQXs1XTKytg2nwifhp2nHDe/NS+I=;
 fh=XAJcCVFRKvcJnQB6WjM87XvQKm93TN8Y/SWzzwlWCF0=;
 b=ldC6CB5TeDbljcJYwk/lx2E6h9GUgmfHeJww1jlOJxr9UbyhSdOvX8ZKF9iLdhhccf
 2VD7+0khZMyi9ofqy8RDUBaGfmeQTr0bnAXxVHNLYL6lpr2CcRZvCqpjiPCDe7qihg3w
 JNQCCrVhveHl7j76RnjQVIDBPFJdtSzJPZiIEvoqtvrrw35kH+fTaaO2Y2/XV9Dw29/e
 oqYUC0QsmQG/+KeX4gq/j6zv4J8gMGo9Feg3lcYvYx+zT3ISQsRzMJ9NM/rux7gMJ25h
 Kt9GQSqvZq8D4izsjEJ440FEe92T9QShWd/FFmzDinYim8C6QHgZYiZs3xef78X+f9je
 GzLw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775728782; x=1776333582; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jt+KgaptQwnbiIvGQXs1XTKytg2nwifhp2nHDe/NS+I=;
 b=WGwtQzZpDrxeM04FT3lSsiGynKNl9tV6fr5Mf3cQ0dhRdxBrMdX9YjQoRGrA5Hn1hu
 fIZKjxNQ9AJdqxSdOfaRMyq1hYGinsrU3nC694GHI+qRovvY9WP4E0RcIYZsxFuphzlc
 wWItrfDq9IPpPhH+Cf4CHDOViOcEBMVqoPaQ4Ey+JjvS750jiNoy809AmnE+AHWKmma5
 Cr4mjjhgF2oEuNAQG25s5ZK/ncluxn1xcnHty9PM99MsgXxtQ9KY0+77EGIig/3dOD77
 nT6T0jLuI5ehKnh1ft6bQ+qu7yvnuQap3DPyZhSP9XhjD2tJi/bhFBDjHmOPVSnoUNCP
 fUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775728782; x=1776333582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jt+KgaptQwnbiIvGQXs1XTKytg2nwifhp2nHDe/NS+I=;
 b=Kd2mKi/S+jMHWf+yAM2S4nqsRGM/OwHLcBpqmbkAmw7MwZjBffuEmDxzItBnNb2zt2
 GJxjDbuqoYXFc5nHoqyXobSoZObXPkKnz/9kj6N3Dcew0wMDqsq/O+UHEuy1cwsLclTx
 DYp8pVTwI9ihStSKuIeSTVg0vYkic1llruKIIETKZ2jdzgqqNTyOulXUCxUD42UVg1Lk
 Y9OA49qGz6beMvqILsSqt0eogt91BG0kwTV7fok4qB8bNJkvrTheTFR2WWOktotjfPqa
 Q4tTJUX4dYZjZZdxfp9PTpW7bnMDDvpcSpPYJ9gB+9W/kcAtGlI59Gn5IvgQ6amPJC77
 M7kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAvk/hIScp8uLQi+aNuM7iKXHbkLGAt8lwb78SNumVowVYJLP85vWSOKGJgGZzoXmhrGk/LFtRMho=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfsWuCZhyN0hyVMDHrwog+QLe4y9Cx77gQhElPML7S/Oo43SL0
 Laigw89X5GncWBQQ2bD69GhxXJQ+KkueYP+YQYJOaCTzqREyWeh4XHMmywiH0v5HF1NSnmRRNkB
 7PqxvfGqfQLT1csL+E6oxvFhbyJzfQ+Djdh/hB++GpA==
X-Gm-Gg: AeBDietwsg1eMOvpum7MpVur8sISS3+zEYYNnYfVxCU5Gs/qvx82yBdO0ZJK2TFd9HZ
 lfp+1pi2y+DYEXX+BGDva6i8Mi6iG0na1QYZcjWnGsHyb3CHPO6a7Qa0alifVTUtpIbUJZbPehq
 n3MGXA8Ec4ZvR95gWfHtKeNR32qIUOaqyUSvzZL+IHUos0uaabp8y6gvXAyvnaMPFQnS642Ycxr
 yFcgrL51zXGkSRyC/tmqNjAOeP5zT3RHb6RHXL7VhDavGgaBSlOoZW9uhzJZwJ3gtD9Gm6MFzBJ
 7ee2PdhVLZRkJLb8cCG3DopoujXEOuIjd9xMk3HfmwdVQE9ZO6I=
X-Received: by 2002:a05:6512:2201:b0:5a1:3d21:7b55 with SMTP id
 2adb3069b0e04-5a33778569amr7413966e87.43.1775728781591; Thu, 09 Apr 2026
 02:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20251031102020.95349-1-marco.crivellari@suse.com>
In-Reply-To: <20251031102020.95349-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 9 Apr 2026 11:59:29 +0200
X-Gm-Features: AQROBzBqe7bIwFZ6E3imviQffF2vEGLSChI_VwvP5fAtQWlwxHZL3ZF5baJtnx8
Message-ID: <CAAofZF6QF9fY3U9sF2FT6XZ37hfyvZ20+canggyOskWynKG+Sw@mail.gmail.com>
Subject: Re: [PATCH 0/2] replaced old wq name,
 added WQ_PERCPU to alloc_workqueue
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
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

On Fri, Oct 31, 2025 at 11:20=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
> Marco Crivellari (2):
>   drm/nouveau: replace use of system_unbound_wq with system_dfl_wq
>   drm/nouveau: WQ_PERCPU added to alloc_workqueue users
>
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 +-
>  drivers/gpu/drm/nouveau/nouveau_drm.c   | 2 +-
>  drivers/gpu/drm/nouveau/nouveau_sched.c | 3 ++-
>  3 files changed, 4 insertions(+), 3 deletions(-)

Hi,

Gentle ping.

Thanks!

--=20

Marco Crivellari

SUSE Labs
