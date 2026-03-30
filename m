Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BD410D14A1
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BFDE10E47E;
	Mon, 30 Mar 2026 11:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="awzCZVap";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 124A510E4A3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:15:59 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso17747535ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774869358; x=1775474158; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QwbMmOxnhNPJFKX0tFv66f1BEnM4IowI567cylvFxpY=;
 b=awzCZVap13P7QWZuNv6Fuj8DpZ0/X/wdBgUBILBcQKrr2GTd3HTaPQ/hn4oemfxFLb
 jWlVpICM6jw/X2vd1CJCl2SpDGLuV6Z1u7B+eVmc40myhVX1ALcFwdxjUC8pI2EocqGu
 BIt0P3nAreONeGPS+LFiRWxzSHy4pw+KM9rI3rQitxoLdOZ8kiQ5tF5moRChfocriZf3
 chXsy0JYCDofXolAHaF1oPWWL0BG1w7KMkNRgX59UaLiOlnIXS7LRhrlub6j2wVcceAG
 /mHSsRYWDQf9El8FgMvmyclD6dVujqdo1aRlCqxZUHHGr2loTXIkF285bphQG/ZFhd83
 LozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774869358; x=1775474158;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QwbMmOxnhNPJFKX0tFv66f1BEnM4IowI567cylvFxpY=;
 b=mZW14fMIf2UXCc/m0aPP1HIuypTsLNwx+3BudnwBxaOVqqZSCFPGK9RaXzrn10xV1X
 RegPVoexYEcREjqXy8j0uv7DZG9nV8VYquSlv7yB5HSSXrQ7uynbhIZvrh5fkjjxZBLo
 ATe00Yz2qqw+sm15jHcpVJuysiuiXp4IjqATVDzhhEIg9eArChwMx4KDeT5H3Gzfb4Gi
 fQIF+5QCqTI0OcyR19aRn1KPo0q5mDlb0Z0BIMipfdTHK5P/b7tg3CG8l0Txll3EeBD1
 9zEwr4gG1k6fCQ/DUu/elC9yCfqrvFMUv2OSQK9hgBXzMOF1hihOwQR4x2ybRjDaC3QB
 kqpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwNsU0HrVq6tnHq+NAc1ETFGqd4XENM6djuqFbqOciMnflclX7Aso0FVVk8O5XyGAqDCqFcsQWGw8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZKR8hVR2BfBVZoIuy6eVR1bzAarNaFSps4gFcZ0kdft+JZsHR
 42fSAVoPqnO4WonUMMxMWfpfUDUbsTAKoRpeACjphgU9u9cbRzT8eWqx
X-Gm-Gg: ATEYQzxlBwcfk7V/tRqHDRiYN9/0UfpPnuEuve3RcudHhbkIkYvz333l3PYtWRo3zFj
 D335I0Ol2f7soYDmf3ueY0I/K8a02YXSl8iF8fh52CPV/X9DiFzDewaOUQYWGlGeWtoYHuhOP1X
 9fJz0FD98jHwVtTiZxs3OC3XQWkZ2YGcvaFehxE7CSVPyCWHI5y2Llh/4ZL/JWLl4vHV1uCywi3
 NnBcVyV41Gu5QKHpMcCMtIBBNjmRg1Ev6mXBsCnM5FEFt4ytRU9cWXBVImRt3KYWpCOWdN+9pmV
 C7AQWCZ9IvUaL+GXGOR4xlyl/haWHVcC8w+3djRh0jEtie2532ZypbDYVun8IQCIQv0PS3e8t9n
 MNlXxKaczzXEsPjPY4NL+XADkdFrwmT4/9Xk7UDUX8oATlZRzv9YhSRurX6jF9VA8ZwvXJiOZGw
 fhxxMsl0WR2qh2F3U=
X-Received: by 2002:a17:903:1392:b0:2b0:708f:4dc7 with SMTP id
 d9443c01a7336-2b0cdcdc34emr86397435ad.29.1774869358504; 
 Mon, 30 Mar 2026 04:15:58 -0700 (PDT)
Received: from localhost ([240d:1a:f76:b500:4431:46e3:c76b:79bc])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b242642b59sm78870575ad.16.2026.03.30.04.15.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 04:15:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Mar 2026 20:15:55 +0900
Message-Id: <DHG2ODK6STM0.25M7U46EBUSZB@gmail.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>,
 <oe-kbuild-all@lists.linux.dev>, "John Hubbard" <jhubbard@nvidia.com>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
From: "Alexandre Courbot" <gnurou@gmail.com>
To: "kernel test robot" <lkp@intel.com>, "Gary Guo" <gary@garyguo.net>
References: <20260326-cmdq-ub-fix-v3-1-96af2148ca5c@nvidia.com>
 <202603281331.1ESuqgfz-lkp@intel.com>
In-Reply-To: <202603281331.1ESuqgfz-lkp@intel.com>
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

On Sat Mar 28, 2026 at 2:53 PM JST, kernel test robot wrote:
> Hi Alexandre,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on dff8302ca1d0e773c90dbeeb05e759f995c95482]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Courbot/=
gpu-nova-core-gsp-fix-undefined-behavior-in-command-queue-code/20260327-003=
216
> base:   dff8302ca1d0e773c90dbeeb05e759f995c95482
> patch link:    https://lore.kernel.org/r/20260326-cmdq-ub-fix-v3-1-96af21=
48ca5c%40nvidia.com
> patch subject: [PATCH v3] gpu: nova-core: gsp: fix undefined behavior in =
command queue code
> config: x86_64-randconfig-102-20260327 (https://download.01.org/0day-ci/a=
rchive/20260328/202603281331.1ESuqgfz-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260328/202603281331.1ESuqgfz-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603281331.1ESuqgfz-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>>> ld.lld: error: undefined symbol: rust_build_error
>    >>> referenced by build_assert.rs:28 (rust/kernel/build_assert.rs:28)
>    >>>               vmlinux.o:(<nova_core::gsp::cmdq::DmaGspMem>::alloca=
te_command)

Been able to reproduce this, but only if I use the 0day compiler (i.e.
just taking the `.config` is not enough).

Bisected all the pointer projections, and the one that triggers this
failure is this line of `driver_write_area`:

    ptr::project!(mut data, [tx..rx - 1]),

... more precisely, the `rx - 1` bit (no problem if I just use `rx`).

This really shouldn't happen because the conditional block we are in has
already determined that `rx !=3D 0 ` and `tx > rx`, so the expression
should be perfectly safe.

I'll keep turning the knobs until I find something that works.
