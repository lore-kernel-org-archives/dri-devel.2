Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAB3C61DCD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D463310F29C;
	Fri, 28 Aug 2026 07:44:57 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B75710E47D
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:33:09 +0000 (UTC)
Received: from Mogu.localdomain (unknown [223.73.65.69])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4ba7c9837;
 Fri, 28 Aug 2026 13:33:06 +0800 (GMT+08:00)
From: MoGGuU <Naixumogu@whut.edu.cn>
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] accel/rocket: Validate BO handle counts on job
 submission
Date: Fri, 28 Aug 2026 13:32:33 +0800
Message-ID: <20260828053233.52725-1-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <apDpz4j2y2_8_pOd@rock-5b-plus>
References: <20260827170608.39511-1-Naixumogu@whut.edu.cn>
 <20260827170608.39511-2-Naixumogu@whut.edu.cn>
 <apDpz4j2y2_8_pOd@rock-5b-plus>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa046db832403a1kunmd795ce9a893f3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTEhPVh8ZGk5NSh1OTkIZTFYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VTUJZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
X-Mailman-Approved-At: Fri, 28 Aug 2026 07:44:56 +0000
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

Thanks, that makes sense.

The two individual checks still need to happen before
drm_gem_objects_lookup(), because its count argument is int. For the
combined count, changing bo_count in rocket_job_push() from u32 to int
makes check_add_overflow() reject sums above INT_MAX before the count is
passed to the reservation helpers.

I addressed this in v3:
https://lore.kernel.org/r/20260828050805.38548-2-Naixumogu@whut.edu.cn

Regards,
MoGGuU
