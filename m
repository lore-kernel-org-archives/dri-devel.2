Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83537CCA46C
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 01:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD5110E05F;
	Sat, 17 Oct 2026 01:07:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FE5010E05F
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 01:07:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3038A6022E;
 Sat, 17 Oct 2026 01:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F681F000C4;
 Sat, 17 Oct 2026 01:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792199235;
 bh=msFf5eZuBAZYQx2jkKUmCGaO9UqE+6lGeQRVz9HPL3s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Vb7876W7Ye52o+RmU1/61DWaqA7e6JdDCBCWL9TbkWGFWjb4bnqj2UK656749Lqop
 mAqABWjveiIsfLlE0QS+K+lo1hElYNl6BU+Zg5T8zXU+AsfyxNHbFuhmZD2WOkSxO4
 UX4iyUed7Fl8ehx2vqvTVmGGVHFSy69r+2DcKl7g06yoBx848O/26RR5jJAg8IsC34
 7hvSrP7WdKn5C1I7uAuv0CA7a0Jw5rdXZuQGWTXaS//MOsSvly5QOuWDb0busrrhsE
 wn+yoTnAeKFyD65T3/GjkQjtdGPLYqT8rurMJbJ5PEaLXLp95EF4h65AKDfhm1bCXK
 oNr0b/y4DjnlA==
Date: Fri, 16 Oct 2026 18:07:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, ogabbay@kernel.org, lizhi.hou@amd.com,
 karol.wachowski@linux.intel.com, jeff.hugo@oss.qualcomm.com,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 youssef.abdulrahman@oss.qualcomm.com
Subject: Re: [PATCH 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
Message-ID: <20261016180714.05fc93c5@kernel.org>
In-Reply-To: <20261009173152.2436195-3-zachary.mckevitt@oss.qualcomm.com>
References: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
 <20261009173152.2436195-3-zachary.mckevitt@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri,  9 Oct 2026 10:31:51 -0700 Zack McKevitt wrote:
> +        type: u64

prefer uint and then no pad
