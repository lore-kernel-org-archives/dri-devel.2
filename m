Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3296EC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98CA910EE10;
	Mon, 14 Sep 2026 12:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LGQFq4jN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B025610EE10
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:12:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6C09F4351C;
 Mon, 14 Sep 2026 12:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B05D1F00898;
 Mon, 14 Sep 2026 12:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789387937;
 bh=UbAaw2XhYMriZB0R4isXtOGHocpJznTQCk/PFrUQPJ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LGQFq4jNPMqOXXd9PamNZJMvv42Bd0UTt135UGfA/QoUqmrwLNBZpF+SOn2SrNM6b
 qVamxm1kwt20eZJjxItY2VeYrq3q7tWEFbFSYDtGTEaTsi+Hba4ejqM3AV2f8j5Xh+
 M4yw5FwrVoOthf+Ir6jKR7ZqUTRBGGVwCGa+9SPgXLn1i1D7kshomWt3nlcMpleCeb
 bz1RLtSBm/6FOimyhHCXEX6YXT8ZsQe2LJhhhlme3/QE75kNRlQ6w+3wqQAIcWpI0E
 mvDuPStmOUcaZaIh0X+/uPsMy6aQbyUElF8sQfq5qg/C8IpJQsoyKRrYDc+FxhRFKF
 SA4Mosr1mNNmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/13] drm/mediatek: mtk_dsi: Cleanup encoder if
 reset fails during bind
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260914115812.22751-5-angelogioacchino.delregno@collabora.com>
References: <20260914115812.22751-1-angelogioacchino.delregno@collabora.com>
 <20260914115812.22751-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 12:12:16 +0000
Message-Id: <20260914121217.0B05D1F00898@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbalanced reference count on error path in `mtk_dsi_poweron`.
- [High] Data race on `dsi->irq_data` between process and IRQ contexts lead=
ing to lost interrupts.
- [High] Missing synchronization in `mtk_dsi_host_transfer` allows concurre=
nt DSI commands to corrupt hardware state.
- [High] Sleeping function `usleep_range()` called from atomic context.
--

commit 911862fd7e3a1163be08c7ed054bcfc694f709a1
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Cleanup encoder if reset fails during bind

When binding the dsi component, the .bind() callback initializes
the encoder, and then will optionally trigger resets. This patch
cleans up the encoder upon reset failure to prevent a use-after-free.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 97b8a91874f5b..0b167b4411e59 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1095,7 +1095,13 @@ static int mtk_dsi_bind(struct device *dev, struct=
 device *master, void *data)
[ ... ]

While reviewing this patch, I noticed a few pre-existing issues in the same
file.

drivers/gpu/drm/mediatek/mtk_dsi.c:mtk_dsi_poweron() {
...
	if (++dsi->refcount !=3D 1)
		return 0;

	ret =3D mipi_dsi_pixel_format_to_bpp(dsi->format);
	if (ret < 0) {
		dev_err(dev, "Unknown MIPI DSI format %d\n", dsi->format);
		return ret;
...
}

[Severity: High]
This is a pre-existing issue, but does this error path fail to decrement th=
e=20
reference count?=20

Since dsi->refcount is incremented at the start of mtk_dsi_poweron(),
returning directly here instead of jumping to err_refcount seems to skip
the decrement. This could lead to an unbalanced count, causing problems
during teardown when mtk_dsi_poweroff() attempts to disable clocks that
were never powered up.


drivers/gpu/drm/mediatek/mtk_dsi.c:mtk_dsi_irq_data_clear() {
...
static void mtk_dsi_irq_data_clear(struct mtk_dsi *dsi, u32 irq_bit)
{
	dsi->irq_data &=3D ~irq_bit;
}
...

[Severity: High]
This isn't a bug introduced by this patch, but is there a data race on
dsi->irq_data between process and IRQ contexts?

If a DSI interrupt fires concurrently while mtk_dsi_irq_data_clear()=20
executes in process context during a DSI host transfer, the non-atomic=20
read-modify-write here could overwrite and erase the flag set by the=20
hardware IRQ handler, potentially causing lost interrupts.


drivers/gpu/drm/mediatek/mtk_dsi.c:mtk_dsi_host_transfer() {
...
static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
				     const struct mipi_dsi_msg *msg)
{
	struct mtk_dsi *dsi =3D host_to_dsi(host);
	struct drm_device *drm =3D dsi->bridge.dev;
	ssize_t recv_cnt;
	u8 read_data[16];
	void *src_addr;
	u8 irq_flag =3D CMD_DONE_INT_FLAG;
	u32 dsi_mode;
	int ret, i;

	dsi_mode =3D readl(dsi->regs + dsi->driver_data->reg_main[DSI_MODE_CTRL]);
	if (dsi_mode & MODE) {
		mtk_dsi_stop(dsi);
...
}

[Severity: High]
This is a pre-existing issue, but does mtk_dsi_host_transfer() lack
synchronization to protect hardware state?

If called concurrently (for example, from a sysfs backlight update while an
atomic display modeset is ongoing), the lack of internal locking for the DSI
controller's registers could allow concurrent commands to corrupt the hardw=
are
state machine and lead to DSI transmission failures.


drivers/gpu/drm/mediatek/mtk_dsi.c:mtk_dsi_lane_ready() {
...
static void mtk_dsi_lane_ready(struct mtk_dsi *dsi)
{
	if (!dsi->lanes_ready) {
		dsi->lanes_ready =3D true;
		mtk_dsi_rxtx_control(dsi);
		usleep_range(30, 100);
		mtk_dsi_reset_dphy(dsi);
		mtk_dsi_clk_ulp_mode_leave(dsi);
		mtk_dsi_lane0_ulp_mode_leave(dsi);
		mtk_dsi_clk_hs_mode(dsi, 0);
		usleep_range(1000, 3000);
...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this code sleep in an=20
atomic context?

It appears drm_atomic_helper_commit_tail() can invoke the bridge atomic=20
pre-enable callback mtk_dsi_bridge_atomic_pre_enable(), which calls=20
mtk_dsi_lane_ready(). Calling usleep_range() from an atomic callback=20
violates DRM subsystem rules and can lead to scheduling while atomic panics=
=20
or warnings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914115812.2275=
1-1-angelogioacchino.delregno@collabora.com?part=3D4
