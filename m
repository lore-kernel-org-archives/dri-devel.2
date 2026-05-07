Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474E1CD3439
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D9B810E286;
	Thu,  7 May 2026 13:32:58 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 617E510E286
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:32:57 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wKyqO-000000005G2-3cSu; Thu, 07 May 2026 13:32:48 +0000
Date: Thu, 7 May 2026 14:32:45 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Junzhi Zhao <junzhi.zhao@mediatek.com>,
 Jie Qiu <jie.qiu@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] drm/mediatek: hdmi: report jack plugged state from
 bridge enable/disable
Message-ID: <afyUfcr8HuFs6EKF@makrotopia.org>
References: <a3e22cbae528c9a38d854a586d1736b860998d41.1776265222.git.daniel@makrotopia.org>
 <c4d62fc2244fb72207855c5a366ff10fad419f2d.1776265222.git.daniel@makrotopia.org>
 <lhxivpwo6aq3ehgzsnkgxnqis5tptmey4dtbhaokyckkl7ghbn@dzaj225pnpk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lhxivpwo6aq3ehgzsnkgxnqis5tptmey4dtbhaokyckkl7ghbn@dzaj225pnpk3>
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

On Thu, May 07, 2026 at 12:51:56PM +0300, Dmitry Baryshkov wrote:
> On Wed, Apr 15, 2026 at 04:04:16PM +0100, Daniel Golle wrote:
> > Notify hdmi-codec of the current sink plugged state from
> > mtk_hdmi_bridge_atomic_enable() and mtk_hdmi_bridge_atomic_disable()
> > via mtk_hdmi_update_plugged_status(). This matches the pattern used
> > by dw-hdmi, which invokes handle_plugged_change() from the bridge
> > enable and disable paths so that ASoC jack state stays in sync with
> > the actual sink presence across atomic commit cycles, and not only
> > on CEC HPD transitions.
> > 
> > Userspace audio daemons (e.g. pipewire) rely on the jack state to
> > route streams, restore per-sink volume levels, and recover the last
> > used device after a reconnect. Without this, those transitions are
> > missed whenever the sink change is driven by a mode set rather than
> > by a bare HPD event.
> 
> I can only hope to see mtk_hdmi to migrate to DRM_BRIDGE_OP_HDMI and
> DRM_BRIDGE_OP_HDMI_AUDIO...
> 
> I think the correct timing was discussed several times and the overall
> conclusion was that the correct time is when the actual HDMI cable is
> being plugged / unplugged. See the discussion around [1] and the
> captured response of Mark Brown.

Thank you for bringing this to my attention. I'll follow up on it.
Meanwhile, can (independent) patch 1/2 already be merged, or at least
get reviewed?
