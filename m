Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D36FC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3747010F0CB;
	Wed,  9 Sep 2026 11:45:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p95mnEzg";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D5110F0CB
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 11:45:50 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482e1b30c94so413541f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 04:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788954349; x=1789559149; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dt2vPzkOUrrSyZHlYPN/ibBa131V7FKwF1pYcgNrnWY=;
 b=p95mnEzg/eOjCs+Q4P8iAeXaHIrwl3d88czwSM3PBQoNqOx5aYeqfl33R2WHnG2plc
 RbnO56QiGKMzrc2HBSnkY44PuGbbX+P1pbFyyHxU8nCOR9bPIcCWTln3qYM8N8ij7t00
 0acAslvZg884LGreay/N6vto5ffAn6r9mJ4qY9ii18v3MlXhvWoSStfGMZYka20sjWaB
 07/YxOHW2Ea7W6/f4Zkfjo5g8QOUIt9JulHkcTVwsuihb6efcS1PTgqN7JHhJgKzdUeq
 BedZHmXn1QfUFtOLriJX4hEXpXuHoOnGlvOlVNHZFRiFKdJytl4iXBsFQ2KnEWiIYvaP
 TevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788954349; x=1789559149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dt2vPzkOUrrSyZHlYPN/ibBa131V7FKwF1pYcgNrnWY=;
 b=BVdBQP4CSzbWsuM2jvaL7kLg7VXqFqrBwka9rG/31J8me9WXt8VMpavbDym3wcfYLl
 FjcodDf9iNAadK85Z2AAz1OSUe5VF/pv3ySa1KwJIcSPeS4uX2bOHqdG98MLj7OR0uhj
 tLyAlw3EXzBbHIUkLRVMgNFq8CO57Z4DiJtIDn+cYUV2rUBo3S/WftuPEGwGoaNWw8OU
 NrN0jz2neJaXU/YIl+gROR5d5tS3n26ue//6VOP5byPDOf4laxkHxH9OC9WawTkJRjyF
 9KC3quZc/riQT+pUl86+hiR/ycPGkcRTokTFyMdtkVhQAEIsvXfiWkhbLNm7sO+GCPQ2
 I7ow==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFFR/R/KSx7AnC/ugSu6g+4m2Dm+i9BpZWhvRibfct+uVjhv5rDX5uGWzczYjWismGHbaEHv/qx3U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mhJd2lDGqeaE1PDIhyVhjNUyNM3BxHR+EdbCtoHk5ehdEuCEkC
 cb9lJ08n0hr8YXI3b0UtDCxSnzid8xD2wbcXRNYFFHYLYzCqG5f5+KM3
X-Gm-Gg: AYBFou2mKfM+NXg/kOXqIqmokNsHXs/kXse9CGMbC/9GwGgIDFiD3t371QeJCRSitUn
 VeugTESqWKqUxbkcxmSTg6pWBUV2OaFrWI5eQjxJx8fLO63LHUaMpGR6MLRTzrvU9PkLXpLryxM
 AHN0MCbzGJe2Pg+sgw3kGbRuT8ulbQ9GQ89H5gEUo447diwrmiNDCIj0G6qzhvbd9sDSv6qZ/2B
 p1HzHSjXSHfqnPiJPYLc+h9ePIt40Qqa6oRLZBH0NcctkgGpSVT78myax84qg+WDBRCjYBjUBc+
 9RKvflG3tF+VLIvaFMt0j7sbNFjlH9Vg8Ui6XGc0rYh81JttFPX8EEawiGlJa4RvqQRQWVQ9dXM
 kdccP94IBZ+fk5PaDAWzJaDdrw6ipvEvtcW64sqEbWF/C1P4imdHCKGWyiWcHbW5h6URFkGnj9s
 jvTykrkHnhqeMvrlwEsSkBo2PTQwk0wR26i02TxvuJ4QrrPGc4AGCDg4qo0L7dXZkCSgaeOLSdU
 TfiIpjGqo/Z8kaCr8G9gliUmJOBZqgPMw4ayaFrc8NTey9XIxNPTJWThBo6mcSzcwUwehUZ0ZTI
 360=
X-Received: by 2002:a05:600c:c494:b0:499:d95a:41f with SMTP id
 5b1f17b1804b1-49d010c3969mr250640235e9.0.1788954348812; 
 Wed, 09 Sep 2026 04:45:48 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B836900E58FC5516AABB3E4.dsl.pool.telekom.hu.
 [2001:4c4e:1b83:6900:e58f:c551:6aab:b3e4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7736132sm459768405e9.12.2026.09.09.04.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 04:45:48 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 2/2] accel/rocket: Fix iommu_group leak and unsafe IRQ
 register access
Date: Wed,  9 Sep 2026 13:45:27 +0200
Message-ID: <20260909114528.9141-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610071045.3414828-2-zhaojinming@uniontech.com>
References: <20260610071045.3414828-2-zhaojinming@uniontech.com>
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

Hi Zhao,

Following up on my mail from July, since this one is still open.

Your 1/2 landed in the meantime - it is in mainline as 9b2dedadf6a9
("accel/rocket: Fix error path handling in rocket_job_run()"). This 2/2
did not, and the leak it fixes is still there today: in current
mainline, and in drm-misc-next, rocket_job_handle_irq() still does

	iommu_detach_group(NULL, iommu_group_get(core->dev));

while the two other call sites in the same file, rocket_job_run() and
the reset path, both use the cached core->iommu_group. So every job that
runs to completion still takes a group reference that nobody puts back.

My offer from July stands, and I would like to make it concrete, because
I think the only thing this needs is for the one-liner to travel alone:

 - If you would like to respin just the leak fix as a standalone v7,
   send it and I will test it on RK3588 (Orange Pi 5 Plus, three NPU
   cores) the same day and reply with Tested-by. I have a benchmark
   here that goes through that exact line thousands of times per run
   with bit-exact output checking, so the tag would mean something.

 - If you would rather not spend more time on it, I am happy to send the
   standalone patch for you, with you as the author - your From:, your
   Signed-off-by, the Fixes: 0810d5ad88a1 tag you already had - and my
   Signed-off-by only as the person posting it. The fix is yours; I do
   not want to take it over, only to stop it from being stuck.

Either way is fine by me. Just say which you prefer, and if I do not
hear back I will assume you are still on it and leave it with you.

The runtime-PM part of the original 2/2 can then be discussed on its
own, without holding up something this small.

Thanks,
Igor Paunovic
