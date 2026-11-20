Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB80606A337
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2IcMwRU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FFF710E8E6;
	Fri, 20 Nov 2026 13:13:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 302CA10E8E6;
 Fri, 20 Nov 2026 13:13:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2941D6137F;
 Fri, 20 Nov 2026 13:13:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795180391;
 b=3BvO8IJDj3ZfRXV+9JhSOEyy2OBN4m4pA2aBf8vDO1OYEEPcMnvCL8VgR1j0V86FY3+H
 GUp0lMj+/j7pBkQGC/b1cnN+V5uklh4TomOnlD4DsQdBfstSYwwKPWxSOFWy+vUwXhIqr
 DZ3KOf6iEPw1WDpSN1aq+y1jVvp5fDEmWB3EZ4681Q5Gi9zFPmhcJFgGAMm0yAK4ywqIw
 JfN1ugn7BN0uIzgBRtoVodFXFhJO/FqkqoZ74BC1OJmWo4CAAxYeAidh4/rM92yz3ddiz
 jsdgOUV8XGjSdkfqJLRt83i+66htNPEkx1Ofpnq5JT6DGlKkZ091SXFcn0DgjNZeCdA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795180391;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=A9ldS+40d764zde9QlR/VfxNDRLzrKYiXwhUHC+I/zg=;
 b=UUjI3VcH2M3O784W7cJnlFvVKIf+Gw6KHLGxSmFBzULqnLLelUvTdvJV3lWEd9nmZH4+
 b22JTubjDZzkJ7nHruYhc51WNVwkNBOfGyEHgloOpNjGLzQZpdjoQdatcbgJgQwNJUEEn
 d0g3JKMtF/4usVs6DWDxUXN+R7ywBzM3VK1CHDAmexwOBuYdVZY/pEny0qJeU1TD53Wcl
 whfCbHDKf7gHYTj/1kEO0QWwT8MfJXrDI3MpdYvt3ns4uW/C1VFhoqTjt7XxYWU4zgBIq
 KXgTmygdRAKZsaRMBd19/nEdeR0zvwVT+5K3uVkhdNkeXhhsQWb3tttragJdzYqvAfA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0DFC61F000CA;
 Fri, 20 Nov 2026 13:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795180391;
 bh=A9ldS+40d764zde9QlR/VfxNDRLzrKYiXwhUHC+I/zg=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=Z2IcMwRULj6EvT0T4FLdasHIgKDsXEt24XamPaaT9VSEx9pA1yOlCaj1eaztbGqAM
 AfHNBVSjg/Io1UBG+2u9ZEU2gyKiEt0BQkyPVioCupTVZ6pF38GBrfn2CbM8YxAHOT
 7rWJWNFgWH6vXvaq6U3AKtHeUihy0Ek8wPgRb8V6zfgL3y33DHTMyJcVOi8zgw73hE
 jp2hnHwuYDAkOQKDYiPH/LBfiMhP8rZMrPxAjDSO8AzcZnit16Tcgyk4njmETVAdGK
 vUZwVmy8Pp1BF+bKGj29zT27OLt4xyV5HE/r3t1IhZcois7FBMdt7Dorq1mvnjIXyQ
 JLU8SMVdARliw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 95D3E498A2;
 Fri, 20 Nov 2026 13:13:00 +0000 (UTC)
From: yzddMr6 via B4 Relay <devnull+yzddmr6.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 21:12:58 +0800
Subject: [PATCH] drm/msm/dsi: Fix double put of the PHY device on probe
 deferral
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-upstream2-msm-dsi-phy-ref-v1-1-d267b87d545f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFlHAGsC/z2MywrCMBBFf6XM2tEmkQr+irjIY2IiJJZMW5TSf
 zep4PLcx1mBqURiuHYrFFoix1euIA4d2KDzgzC6yiB7OQghe5xHngrpJDFxQscRx/DBQh4NeeU
 sKedpgPofaxjfu/t2/zHP5kl2asK2MJoJTdHZhhb91ae9WC7HMxarYNu+Btjip6cAAAA=
X-Change-ID: 20261120-upstream2-msm-dsi-phy-ref-bef3dce3dfe6
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miaoqian Lin <linmq006@gmail.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 yzddMr6 <yzddmr6@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795180379; l=2738;
 i=yzddmr6@gmail.com; s=20261028; h=from:subject:message-id;
 bh=UCVOCZGuxoSVYeQlAgN1/asYu4mtdgFa/QW169bkdC0=;
 b=7QmFwZrvmrODkce+oy/gZC9S60KYzd01Pcnk2A90Mlmot2xKuEHEWd+NWCw/J7sx7fn96rqNt
 8HLm21FetuqBbfXBNqL78hOjmlhrRxBqtU5JJms6lLdvRn58302t7l3
X-Developer-Key: i=yzddmr6@gmail.com; a=ed25519;
 pk=QLT2mwairk4R38oU379hkHynqjoLrlqd0Cl1ERUqIqY=
X-Endpoint-Received: by B4 Relay for yzddmr6@gmail.com/20261028 with
 auth_id=1489
X-Original-From: yzddMr6 <yzddmr6@gmail.com>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: yzddmr6@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_REPLYTO,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: yzddMr6 <yzddmr6@gmail.com>

Since commit 6977cc89c875 ("drm/msm/dsi: Fix some reference counted
resource leaks"), dsi_get_phy() stores the PHY device it looked up in
msm_dsi->phy_dev before it checks whether the PHY driver has bound, and
dsi_destroy() drops that reference. dsi_init() calls dsi_destroy() when
dsi_get_phy() fails.

Commit c04c3148ca12 ("drm/msm/dsi: Fix missing put_device() call in
dsi_get_phy") then added a put_device() for the case where the PHY
device exists but has no driver data yet. In that case the reference is
now dropped twice, once in dsi_get_phy() and again in dsi_destroy(), so
each probe deferral for this reason takes one reference too many from
the PHY platform device. Enough deferrals underflow its refcount and
free it while it is still registered.

fw_devlink normally keeps the DSI host from probing before its PHY has
bound. The path is reached with fw_devlink=permissive or off, and after
the deferred probe timeout when no driver matches the PHY device, as
the device link is relaxed then and every probe retry of the DSI host
drops another reference.

Drop the put_device() and leave the reference to dsi_destroy(). This
effectively reverts that commit and brings back the single check that
it split in two.

The double put was found with the help of an AI coding assistant during
a review of the driver.

Fixes: c04c3148ca12 ("drm/msm/dsi: Fix missing put_device() call in dsi_get_phy")
Signed-off-by: yzddMr6 <yzddmr6@gmail.com>
---
Found by reading the code; I have not hit this on hardware, and there
is no reproducer. Build-tested only: drivers/gpu/drm/msm/ with W=1
(arm64 defconfig) on the base commit below, no new warnings.

I used an AI coding assistant for this work. It found the double put
while reviewing the driver and drafted this patch and changelog. I have
reviewed the change.
---
 drivers/gpu/drm/msm/dsi/dsi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 090726be5061..5f9a1409432a 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -44,12 +44,7 @@ static int dsi_get_phy(struct msm_dsi *msm_dsi)
 
 	of_node_put(phy_node);
 
-	if (!phy_pdev) {
-		DRM_DEV_ERROR(&pdev->dev, "%s: phy driver is not ready\n", __func__);
-		return -EPROBE_DEFER;
-	}
-	if (!msm_dsi->phy) {
-		put_device(&phy_pdev->dev);
+	if (!phy_pdev || !msm_dsi->phy) {
 		DRM_DEV_ERROR(&pdev->dev, "%s: phy driver is not ready\n", __func__);
 		return -EPROBE_DEFER;
 	}

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261120-upstream2-msm-dsi-phy-ref-bef3dce3dfe6

Best regards,
--  
yzddMr6 <yzddmr6@gmail.com>


