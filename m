Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E108CD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 21:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C9910E568;
	Sat,  6 Jun 2026 21:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=mail.ru header.i=@mail.ru header.b="O795JheG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="H6VcPnHa";
	dkim-atps=neutral
X-Greylist: delayed 908 seconds by postgrey-1.36 at gabe;
 Sat, 06 Jun 2026 21:41:39 UTC
Received: from send170.i.mail.ru (send170.i.mail.ru [95.163.59.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A780010E568;
 Sat,  6 Jun 2026 21:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:X-Cloud-Ids;
 bh=RRlpEfg+rAq4/xxw12K5WLSfzTiih4xrF1skPzLufQM=; t=1780782099; x=1780872099; 
 b=O795JheGtiRdoLL+oxbyqh1lRdS4RPUGe5Z0o9VG0aHHofaEdjXtELU8+eIvhWCBi+z6bUiL3Hf
 GGbhEsN9SyJlqu67AliLxWxhnULcK3DZUeF29DtWrhxABZ/ceOV+onE69gGcPI4bAF5vCJLMelfe1
 MI3++cBQsQdDYT1pHmZ3UfhoOmE9ZjWaxqZXWUBs7eSC0pHHPbvIAliFshCOc+lfCaYQhKTUGfAEl
 JgBHeLcdARqpormkfHJlPA+LAKWhxNXX5xPt35sJWggkWhBLTXV/gQEqEUR73BsVYxCT9jxfDrT9b
 0SlGW+pBsUhwH0EQuYphflr14cd+t7RjPo/w==;
Received: from [10.113.93.26] (port=45900 helo=send128.i.mail.ru)
 by exim-fallback-8699f4bc65-bqhcr with esmtp (envelope-from
 <listdansp@mail.ru>)
 id 1wVyXE-00000000RsF-3wyx; Sun, 07 Jun 2026 00:26:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
 To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=RRlpEfg+rAq4/xxw12K5WLSfzTiih4xrF1skPzLufQM=; t=1780781188; x=1780871188; 
 b=H6VcPnHa41WhTFiwGyPtrr+nA3e62R65/yPJYjvM28DToE1jqCjNTaT5nD04LZtSS6bgwARZwOU
 KM/Cd/RHl3biYr7ImUVIsveT1FCJzV2FkKDnmiO4W9Ecqnf6WeS93Az1JoMr4SgG6B04v98O5VQKX
 PRuUTwGfvbx1tLCT7akhY8YhpCWO3gfjX6dtPMsZSC4KtNwf2IhJ+B3i/YhnYM6fE6AXoSyX2e6Px
 cSiOyRzRAsKGVT51oGcZsg9IoER8/HorozNYA031wWMEl7uhPwcVw3U2sqATKM3lgj8ZRWjz/f9FH
 /V30PV6fMfhPnNIsXZRuCWfLGNDhRmYQIF+g==;
Received: by exim-smtp-85dd497b6-xgtt4 with esmtpa (envelope-from
 <listdansp@mail.ru>)
 id 1wVyX5-00000000Qns-3JHO; Sun, 07 Jun 2026 00:26:20 +0300
From: Danila Chernetsov <listdansp@mail.ru>
To: Austin Zheng <austin.zheng@amd.com>
Cc: Danila Chernetsov <listdansp@mail.ru>, Jun Lei <jun.lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] drm/amd/display: Validate max_fclk_mhz in DML2 policy builder
Date: Sat,  6 Jun 2026 21:25:03 +0000
Message-Id: <20260606212503.140638-1-listdansp@mail.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9FAD06046D747065BFD1F8B0A1B9B9707D8C8F67DBDBE5FA5182A05F5380850409621B98EC0D4CA463DE06ABAFEAF6705D035D994BFFA62EC9D2EAEA2A1F4BB08249BFCD68258DFAF
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE765EC468FF5F3030AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637D24CDE3D695BBBC6EA1F7E6F0F101C67CDEEF6D7F21E0D1D9295C2E9FA3191EE1B59CA4C82EFA6586985FD7387DF6F77C7E4FDACEF09268D33FEC8FC032966066F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7F1FF917D59728F209FA2833FD35BB23D9E625A9149C048EE1E561CDFBCA1751FC26CFBAC0749D213D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B55B19328CBC4F849A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC3C79C0CE7F06F4BC3AA81AA40904B5D9CF19DD082D7633A0C84D3B47A649675F3AA81AA40904B5D98AA50765F79006374B811A4946B142CFD81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89FAE2BFB9A60527F4F262FEC7FBD7D1F5BB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A57702970249F775C75002B1117B3ED696906CCCD785A21358E20DC3F561CE4150823CB91A9FED034534781492E4B8EEADDFC043C56F70D752C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659A31CB613A1CE620CF7CC49A6AB6E3800CD24BA6E3248586704A9E8A34112657344EB9665BB483114B8341EE9D5BE9A0A22987DF0AD52FB34505C2008A0FF216FE797B7B01A16DD4552EE4E5D9E54FDA44DC34E6FDC38EA02973FA9AB552041BE982BEF0C6C01360AC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVYrk7BQKFwEtIM1xCxg4W1OhHIaay3etpg==
X-Mailru-Sender: 4CE1109FD677D277A25EA9D9B320DF53ED077134A253E0C2B951B70A5BD4BD8E654D62B877AE6CE6AABC8C0DF00C54FAC53BD13D3F6EEB2F3DDE9B364B0DF289C95E31D8FCF52BE1594FB4C9F0DBF4120D4ABDE8C577C2ED
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B48C57FD6B8CC3B424983C464901AA611741A5A3C9AC30A3C768F3CF0E9FE49B69EB953A509C22E655B12A3BF3B648CB9CC52792B4F660D8B870F1A8B60B048D10B63DD5FB2B6B9523
X-7FA49CB5: 0D63561A33F958A5075DB5AE9D2FA28F5002B1117B3ED696EC4FD808CD03D3013D1B8CC3424EAECF02ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZhQpxvoob8R/EZ4AvdjPjuA==
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok
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

dml2_policy_build_synthetic_soc_states() validates that several
derived maximum clock values are non-zero before constructing
synthetic SOC states.

However, max_fclk_mhz is not included in the validation despite
later logic assuming the presence of at least one valid FCLK level.
If all FCLK entries are zero, num_fclk_dpms remains zero, causing
an integer underflow (0 - 1) and out-of-bounds array access.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7966f319c66d ("drm/amd/display: Introduce DML2")
Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c
index ef693f608d59..70f418ee5dd2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c
@@ -157,7 +157,8 @@ int dml2_policy_build_synthetic_soc_states(struct dml2_policy_build_synthetic_so
 			num_uclk_dpms++;
 	}
 
-	if (!max_dcfclk_mhz || !max_dispclk_mhz || !max_dppclk_mhz || !max_phyclk_mhz || !max_dtbclk_mhz)
+	if (!max_dcfclk_mhz || !max_dispclk_mhz || !max_dppclk_mhz || !max_phyclk_mhz ||
+		!max_dtbclk_mhz || !max_fclk_mhz)
 		return -1;
 
 	p->out_states->num_states = 0;
-- 
2.25.1

