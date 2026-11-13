Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E204C606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=MjnHBAiE;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=VWff5/SZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C941511256C;
	Fri, 13 Nov 2026 13:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="MjnHBAiE";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="VWff5/SZ";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AA0210E6DE
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794533094; bh=W5N2UpU2WP2XosedmWfVJ2y
 8q8qrsyj1aKQr2fEVN1o=; b=MjnHBAiEDaVAfPG8/bfN1F0ChFcUrFayBdTIddksngM/Ai8T+M
 BXII0j0t9cYANEFxJXq46l8athZmUHeIwuAA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794533094; bh=W5N2UpU2WP2XosedmWfVJ2y
 8q8qrsyj1aKQr2fEVN1o=; b=VWff5/SZacMVrTaKOESo0XHubfdxG4RlSAhxZ5Yc9JjBM5bkth
 zZyLG2NIxhbM3XnWjecPM8aeU1NphpErinEVo4Tzcrq/z03Gtw8LQQ0QAb/ZWk69mcBXN3APOWJ
 GB/4ieXx0UMGFcpjYteaX81csoiVeOyFCmnwriJIpl9l+mifdvFgW5iDE82rX/n0k2uJUpseDl7
 0e1cQq3Ccwi/QZwVDGFMM3TZrpCnclxLYntvMmG0cBAeTFHTQdYnRxQ53gIdIErFeonnWhlJwa6
 0V1VYTc15qzC06FuILg3DhZMAlJHlg69p1nFNtfAb0FaAuNy50NNl+NbSS4Ug29jTxQ==;
From: erebion <erebion@erebion.eu>
Date: Fri, 13 Nov 2026 02:24:46 +0100
Subject: [PATCH v4 02/12] arm64: dts: qcom: sm6350-lena: rename
 touch-en-regulator
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-pdx213-upstream-3-v4-2-4b01c50a821c@erebion.eu>
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
In-Reply-To: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 erebion <erebion@erebion.eu>, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794533093; l=898;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=PqK5DzmB7gm2n3sxiBk3xW0xmQVbP+Ec2QYj1wB7pf0=;
 b=KE4yKtSMgh6v+LrULyfjg3QcyVawVraTiNPAaxWeSkJnPmJenVRvuM9fkPTZ23aXXPN/RL6/K
 y8dlwnzO0H9CcppyUH1qXWsB2wg5ADx9B/LVtV48SCBZbtleOhbUKyH
X-Developer-Key: i=erebion@erebion.eu; a=ed25519;
 pk=rOCVlR8khmBtCFe4ZlDcbCbIcORxdaNzPDkoIiHM7xc=
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:43:28 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rename touch-en-regulator -> regulator-touch-en, to
keep any future fixed-regulator sorted together

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: erebion <erebion@erebion.eu>
---
 arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 4d78c500d00d3..ca44219e1a67d 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -46,7 +46,7 @@ key-volume-down {
 		};
 	};
 
-	touch_en_vreg: touch-en-regulator {
+	touch_en_vreg: regulator-touch-en {
 		compatible = "regulator-fixed";
 		regulator-name = "touch_en_vreg";
 		gpio = <&tlmm 10 GPIO_ACTIVE_HIGH>;

-- 
2.53.0

