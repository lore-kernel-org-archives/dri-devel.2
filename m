Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6F7C982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 22:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2271D10E4B8;
	Tue, 22 Sep 2026 22:38:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jrdq+H0T";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77EF710E4B8
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 22:38:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 13F9A4167D;
 Tue, 22 Sep 2026 22:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2658C2BCF5;
 Tue, 22 Sep 2026 22:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790116730;
 bh=0Aqe28z8QGQo4XbEFhqrQmVqEe04FzqL1C5imTxDlJU=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=jrdq+H0TUHPV81Y2fKNcK3bmYgy/aQYouyJcWLCiE+PBY77dc/6CWcxTgvgjCvFbG
 RLssQlOGQVxFHrpxwMxLHRVLNv3wr+ZddCWxFrMNp29sHLSCwpimLF7TnpfUankNc2
 mx3tvE/YqfmhdB8VLjYurCsbOgeEFgDKmnHYCPRU5sJA4DELQf7xyum5EgsIsEwOgb
 0PBvhbDHmeu/xRHolVlV4/+E1UXA1hgI39KPkQ1i3coDvjZP45KvGTdsY6N7UVcYLf
 k/+VkogBtnZSg9UojukEp40CmqZdhmgLxAg0KWNFmj8xNq+A3IpE1ClEIcgQtxYDZX
 I/uForgGrvptw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BD960C982FE;
 Tue, 22 Sep 2026 22:38:49 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 23 Sep 2026 00:38:35 +0200
Subject: [PATCH] misc: fastrpc: Don't fail probe when the SDSP memory
 assign fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-fastrpc-fail-slow-v1-1-f3f6fabba6e3@ixit.cz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw5AQBBF0a1IjXVC+wRbEQNKoUSQrvZJxN41R
 i9n8O4FQoZJoPAuMLSz8DI7hL4HONRzT4pbZ9CBToNcR6qrxZoV3fKkZFoOFbeYRTmGaZYguN9
 qqOPza5bVb9makdC+IbjvB2r/TIt1AAAA
X-Change-ID: 20260923-fastrpc-fail-slow-4dc839c1685c
To: Srinivas Kandagatla <srini@kernel.org>, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Xingjing Deng <micro6947@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 stable@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2927; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=LVflJZ/2wlziXXcgkjmUlvyrIA4JxMm8+0Fb6m1yJ2E=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqswN4Ww4Isn3b4+WGISIldgE1WYUqWK/0/8UBi
 M1hUa64M8eJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCarMDeAAKCRBgAj/E00kg
 cp2GD/9xpT04KcafxxzzzuuUOJgWk8Dnw017e+ML+4eNZ+x96udDkrJ26VRQ1lqKDPFSdP42hvq
 DgNVELWCJuJJ5l3F3vTfxDCzCicDK9d6lTYEw4RKO0UNgcXIEWxGadAAlmBZZT1V0P06eSCCqSE
 YqqIgcAduy0/GxU4M+cxUrmQ0TWf1eSPT2pTdEwCod6NqoDQ0D5vEWzfro8lAsunNTwDmgMwknO
 S8K+CDjufT1hgQy0ivffOW9IttgJy7Y5kdmuInnuJFZxQoxdYvuh7wzBFTfPXMOZYDyHG7xwO6U
 cdcaqYCqvsnLhpLiNps6PeX2Vgcz1ViuTxKLC868vOpikeML6yZPMnaJVd+rOnsTm55S+101J8x
 umLUQCiVFMhdOL9Pr0dQlOmAP9h9ML3/BaMuiR6CXsneIX4OYPhdggHikBRfGDqNXrbWIawmab2
 nQxixDbyzWBYEcbngxE5XVGSSD5s6P14hiiAwModMGE5ZDfyTa4gZwf4J1T7G2xS6tLvYDFN6IC
 nPj+e4wvyJVFFgRdf9HhuH6QqdTnvutEKoaUfO0iZkDi+kfvpVaLoxqqY2FQ7X8H5IuPKy3JF1I
 hp8JnhKU0rnCifDri+E9poYZhSRLKZP+EuQwp8DI9kuoKadNnsKMxeDlORXdgBcvudyqej0k+MV
 N3R0Vi7dj8ywbOA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: David Heidelberg <david@ixit.cz>

A failed qcom_scm_assign_mem() aborts fastrpc_rpmsg_probe(). On SDM845 this
turns every SLPI subsystem restart into an endless probe failure loop:

 remoteproc3: crash detected in slpi: type fatal error
 remoteproc3: remote processor slpi is now up
 qcom_scm firmware:scm: Assign memory protection call failed -22
 qcom,fastrpc 5c00000.remoteproc:glink-edge.fastrpcglink-apps-dsp.-1.-1: probe with driver qcom,fastrpc failed with error -22
 qcom,fastrpc 5c00000.remoteproc:glink-edge.fastrpcglink-apps-dsp.-1.-1: rpmsg_dev_probe: failed: -22

The first assign succeeds and hands the reserved region to the VMIDs
described in qcom,vmids. qcom_scm_assign_mem() reports the resulting
owner set back through @srcvm, but the driver discards it, and nothing
reverses the assignment in fastrpc_rpmsg_remove(). When the glink
channel is re-announced after a subsystem restart, probe passes
src_perms = BIT(QCOM_SCM_VMID_HLOS) again, which no longer describes the
region, and the firmware rejects the call with -EINVAL.

At that point the region is already assigned, and HLOS is part of the
destination VMID list, so both the host and the DSP keep access. Failing
the probe only removes /dev/fastrpc-sdsp and makes the remote reopen the
channel, repeating the cycle indefinitely. Warn and continue instead

Assisted-by: LLM
Cc: stable@vger.kernel.org
Fixes: 6a502776f4a4 ("misc: fastrpc: check qcom_scm_assign_mem() return in rpmsg_probe")
Signed-off-by: David Heidelberg <david@ixit.cz>
---
Tracking the current owner set so the re-assign is issued with the
correct source VMIDs is a separate fix, but I assume it would make sense
to keep that to someone with more knowledge of fastrpc.

I aim here to reverting into usable state again which can be also
backported.

Tested on Pixel 3 and 3 XL.
---
 drivers/misc/fastrpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 90fd669636ec1..41943a3d496af 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2590,17 +2590,19 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 
 		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
 		if (!err) {
 			src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
 			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
 				    data->vmperms, data->vmcount);
 			if (err)
-				goto err_free_data;
+				dev_warn(rdev,
+					 "assign memory to SDSP failed: %d\n",
+					 err);
 		}
 
 	}
 
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
 	data->secure = secure_dsp;
 	data->soc_data = soc_data;
 	data->poll_mode_supported = soc_data->poll_mode_supported ||

---
base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
change-id: 20260923-fastrpc-fail-slow-4dc839c1685c

Best regards,
--  
David Heidelberg <david@ixit.cz>


