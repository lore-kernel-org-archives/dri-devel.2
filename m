Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B03606A320
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B7B112141;
	Thu, 29 Oct 2026 09:45:12 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3256B112141
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 09:45:08 +0000 (UTC)
X-QQ-mid: zesmtpip4t1793267095te2ba335f
X-QQ-Originating-IP: aizOpLrqBFRuyE4N0lIdY8t7yRxMvqkbkK0qIj00TuM=
Received: from [192.168.30.244] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 29 Oct 2026 17:44:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6592915629139523209
EX-QQ-RecipientCnt: 31
From: Xilin Wu <sophon@radxa.com>
Date: Thu, 29 Oct 2026 17:44:31 +0800
Subject: [PATCH v3 4/4] firmware: qcom: scm: Allow QSEECOM for Radxa Dragon Q8B
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-q8b-dts-v3-4-655696dfec45@radxa.com>
References: <20261029-q8b-dts-v3-0-655696dfec45@radxa.com>
In-Reply-To: <20261029-q8b-dts-v3-0-655696dfec45@radxa.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=731; i=sophon@radxa.com;
 h=from:subject:message-id; bh=ha+6AXBZg8vPgpy9CUy+X6vPtWkIMSbkDFJ7rZDLj7g=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFmPRRs9e4W1fVibBPcf2HZ7o4PjX7X36VLhsrrr7EXvd
 PfLRl7oKGVhEONikBVTZFGIZ5jLXpl77alYqR7MHFYmkCEMXJwCMJEP1xj+h+Rwr3dJdZ9+Zcei
 e7LL1Df4nWiWsWG0e63+5APD8oWPnzMy/JdOK/Lb/zaddSfLS43Umpyfp/Q2++wPmiT+8/XFSws
 28gIA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N4KH/PyO63QvlfhRmHW3lhlC9Y80d5G39Z3Mt8h3O/31GMfKRCJZs+61
 SdZIejoFles1DXpH5CTegOaoefX2YkUCnli5tWmDyq/apdg+CYivKpE6PKp//QBl7925HM4
 +AH2JUIvwMkcCNW4OBryB9hIxpOj6IbbeY4DVH9MVKAU8skd3jrE69IE9R8xscT/J46wn58
 ZAdflBGU8Ra2oo+TX77EiR6GcjwKIyevWZh/g4qAGa9gvI6Pnp2Lrm76/4kH6eubOtcjUYW
 uu8tECu15hUNdir8dQqvE/vUANsscluMO1KQhOzKe667MsEU/ocoscqr81eL+mkVd3snvnA
 IQPy9NQMWzShWSRl61h5plHuVJfc6ek/7CezDbg53cMWVNmMyHt+g7Nzsc9Hzh0aCDYqOE/
 QtkESDqq5VY76a5kEQYJ3fuHsWKnLz8FNM4bgMwboDXNWrTrPGVxhwT0lsQ6BYe4zfqo6Cz
 ZyMaWfPe+iKo4YFI/lMYKIVlLHgIzCQJ1jQ87tMHhqPtUokQ5Vba9mNqqEhEoM4FGhY6uf7
 Ox5YfnlhPnjmm48ZryVPuwvGI5FbIp+iYne8KxBiOFvSlG2SW4qg59cf/t6t97t3Qr8LuTY
 2qa2mEv8Aq7xbvOFBuJVI/jGBnXP2LbHkfpSbrxKE5BVJI5we1dAogN9E2l918eBGp/odVs
 rjnrrmnZ14G09Y6eLP7QBecHo9eYdHo/uFTt96piaY+8uHqZLGc1e0yzl6sxP5om0EJPvhG
 SpuZMAjk2k6HIb8d3Xmc0x2r+D6tTbc6pQZcTQqLviiG2s2sWurcvpk7QyzlTfLVHDdYJxL
 kuRqZnf4IUMlaIi4HzUnmutDF1ydfUwHZD6r/bunK3m7InOMiWbQV76eFwTTBQQGyvZiK1o
 VpJP8LNTl+B2FfF/SIiFvz2zAliC2uNld7l78gtrW59VGSVyUc2riK58ZJPaoQ6bLFFOcdt
 fLL2U70QmWRuIeeqwHc3cz4RZWHJPWjb11aAtuspA/rfGcRSMUlxQ7tPBLsUxUGkL1sFdZB
 rk5ISAK7Ex/djA6T39Vt0NmwY5oj0+T5oMPkEoqLGpm3PdRFtopMT1fuC0ik81F+luLbAO4
 Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add Radxa Dragon Q8B to the QSEECOM allowlist for enabling access to
efivars and uefi bootloader.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/firmware/qcom/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 43e250faea75..0cb6f8e3a5d3 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2266,6 +2266,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "qcom,x1e80100-crd" },
 	{ .compatible = "qcom,x1e80100-qcp" },
 	{ .compatible = "qcom,x1p42100-crd" },
+	{ .compatible = "radxa,dragon-q8b" },
 	{ }
 };
 

-- 
2.56.0

