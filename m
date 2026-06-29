Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D28C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4699C10E02A;
	Mon, 29 Jun 2026 04:37:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K1xE2PRe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5B1D10E02A
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 04:37:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 83B3A60054;
 Mon, 29 Jun 2026 04:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CCA1F000E9;
 Mon, 29 Jun 2026 04:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1782707825;
 bh=UA/8TEqnLRBtg+CS42jkaVku5zkA76i8pZuF/RPL1ZM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=K1xE2PRee0tRW5Fj0/Pog1F+wyeWXqy7MTwYeWptzrT+TbYhTfIHi//3TmCWCX8HJ
 SJqk7+HQ+bznYv7rNlG7xV//+CS0uFiUL5jfy2gyfanZk5WoCPtaVzeW0/zQy9Bkk9
 otphbhj2ungjvDCfE6vmholxEKjaj+b49QjtVi7o=
Date: Mon, 29 Jun 2026 06:35:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 kees@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 tomi.valkeinen@ideasonboard.com, mcanal@igalia.com,
 suraj.kandpal@intel.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/display: fix MST branch device refcount leak on
 DPCD write failure
Message-ID: <2026062906-bonding-pointless-f53d@gregkh>
References: <20260628133344.46188-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628133344.46188-1-vulab@iscas.ac.cn>
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

On Sun, Jun 28, 2026 at 09:33:44PM +0800, WenTao Liang wrote:
> drm_dp_add_mst_branch_device initializes mstb with refcount 1, and
> drm_dp_mst_topology_get_mstb increments it to 2. When
> drm_dp_dpcd_write_byte fails, out_unlock performs only one
> drm_dp_mst_topology_put_mstb, leaving the other reference stored in
> mgr->mst_primary. Since MST was not successfully enabled, no disable path
> will clean it up.
> 
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>

I did?  Where did I do that?

> Fixes: 7a3cbf590e63 ("drm/mst: Some style improvements in drm_dp_mst_topology_mgr_set_mst()")
> Cc: stable@vger.kernel.org
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Again, you need to document the tools you used to find/fix this with
assisted-by, right?  Please read our documentation for when you use
LLMs.

thanks,

greg k-h
