Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54BECCA462
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 05:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B984C10E050;
	Sat, 17 Oct 2026 05:30:42 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA13B10E050
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 05:30:35 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2e60f9af6e6so3470055ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 22:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1792215035; x=1792819835; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A9n2Zo5diFt/3lyLr9LLZJwOhqcYigsp70hUBRz/SN8=;
 b=f5g6IPVjrvaPxKe8XbldkbihZ94nmiVUMRK+Fvj4h5ClijX1EIGdL/YgixJkbqON2E
 EvmtC9S6W/B3Sc31dCgzdGuViUjhR+Me8Erf/Fe8mxxPHMDpD+aEpZ4PSJQ6197nbgvT
 8lJyW1sDmm80vh+tl61zbnZd1NDdWLpeemc0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792215035; x=1792819835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A9n2Zo5diFt/3lyLr9LLZJwOhqcYigsp70hUBRz/SN8=;
 b=hYPRjK2ZMdNVXsQnmXRXDc3i4R5rO7cpobHuA5sbMJXEMiMFhUwKAn6F/OmA2mNmZU
 gqsHQFFgbn5CVKoqf2HJ8e8N7aNhLXkDLhvT7cgoBq+aEJ6v9iSR3WomYG5rpFf6SfoY
 vJbrmkLm7mxf/mFRehfo/CA++JZ1krmlaQPmsGvGycEa+9wKTe5E6DXrtdzd6Sa9sKgB
 UrnK6k3D5dhIcTr+GKsPF8GkxHTGXh1024VCW6yzdzkyJDYYQoE8ZzODBEQU0lAk5MbQ
 z/2vDFvflOxJQzNDGsWiWSS1P/8L/duJ6jDA7/RMxInVShoyssVR3c3xQZlIm+63roHE
 cuGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/LvEvagqosHcv7a9ZCUSEpZwtfcnixTO+VdjlheBNvkyUhqSuqswb6zQjY2J+AlSnjyhfi9mOXdM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ40uuUJe/KNAyyFG6AaMzvF28MIi46Pkrd2iLIUYJUxS3czOJt
 as17erpY7YQgL7qsQdFwdwhW+IJEdmTYTX1i3NYHhL/o6m/giH/8o3yGh0YR/3Q7nlA=
X-Gm-Gg: AYBFou1ItytGPpUobElH6T6O6d7Zq9Zx8qsDeRpk1BkEtRPpXzWaRF0cIZRT/64/KiE
 eihVUFFhiqhHhlG4FTkOXyd9FV1CgcTWBfRkZrysGfzhWFdwjsDnjrrhVye3a32cc6CMIgF3nTK
 HyAJSOPgQet6VA7l4BpIDmAmU5vR2YX54Y7FuqYvDZWYXio3TGyvOWfuZoRFoSpXB3nR+slWMDs
 JSP7zAoq9egrV2PnKCOK9SUVOLfJZisuIkMURfoKKHBU6sLRO6CjuzmKWsjVTwz+Ncc/G/U/ssO
 UavLDCv7WUUTW3U36rYcShNa457/Xsax9jDSBwoyDX57qdrRHFApvHYPRGkujkS0jdiqY2BZtTH
 a2tRgPgtcUCOU8CPUr8uY4bRqKvYx8tmDmJzN7QSlYkOk0UKCkhHXhCiq9pxjyGUzDwyKDlM2Aq
 DfmJ/UxeVxNGtfpXFNlDMBiHguLFDnP5Qw46C/2OqtQi4UYnRjr45RYopzrt8QjirRUWbkyIeA
X-Received: by 2002:a17:902:d48c:b0:2e9:b7ca:cd5e with SMTP id
 d9443c01a7336-2e9b7cad85bmr5277485ad.62.1792215035336; 
 Fri, 16 Oct 2026 22:30:35 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e8b2001sm18691115ad.71.2026.10.16.22.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 22:30:34 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] accel/rocket: Fix iommu_group leak and unsafe IRQ
 register access
Date: Sat, 17 Oct 2026 14:30:11 +0900
Message-ID: <20261017053013.4403-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610071045.3414828-2-zhaojinming@uniontech.com>
References: <20260610071045.3414828-1-zhaojinming@uniontech.com>
 <20260610071045.3414828-2-zhaojinming@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Wed, Jun 10, 2026 at 03:10:45PM +0800, ZhaoJinming wrote:
> -			iommu_detach_group(NULL, iommu_group_get(core->dev));
> +			iommu_detach_group(NULL, core->iommu_group);

Looks right. I agree with Igor that this should go on its own; for a
standalone version:

Reviewed-by: Sidong Yang <sidong.yang@furiosa.ai>

>    device on the same IRQ line triggers an interrupt while the NPU is
>    suspended, register reads return 0xffffffff, spuriously triggering
>    WARN_ON macros and falsely returning IRQ_WAKE_THREAD.

On RK3588 the line is shared with the core's own IOMMU, so the guard
makes sense. But it's worse than a WARN: on a ROCK 5B+, reading
INTERRUPT_RAW_STATUS through /dev/mem while the core was runtime
suspended hung the board. Please mention both in the commit message.

> +	ret = pm_runtime_get_if_active(core->dev);
> +	if (ret == 0)
> +		return IRQ_NONE;

This returns -EINVAL while runtime PM is disabled (e.g. during
pm_runtime_force_suspend()), and then the registers are read anyway.
Returning IRQ_NONE for ret <= 0, as rk_iommu_irq() does, covers that
and drops the "if (ret > 0)" checks.

With that, this part looks good to me too.

Thanks,
Sidong
