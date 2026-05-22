Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4E9CD5BB7
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A84010F5F0;
	Fri, 22 May 2026 14:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VaYu/rnD";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F3D710E168
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:07:36 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-369576666d5so3258617a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 23:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779430055; x=1780034855; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GxXWPb5b7IE1WF73BuquobJeXJY1I1vTx7dwyLAryI=;
 b=VaYu/rnDd54qlEy5UoobhaQSGEz/9oqcqwXH8D2eABIf+vqzTShOD4H7eNTJ6ACDFv
 xPtrOBagbo4P6ZJD1fVW2dYbMtNlHBFYOiO+cllNo/WXVA3a5rVW6PfXULgtUdJ4w/mr
 YqvC03SyFXz/3Ec1KYaedwL5wfs/J5698DX1bpi3GiP9JND7dtC7NHX7630b2lIsG75S
 rMnpKvT+un6qDNOWmFcDgqibd9NtL5xwdjKiTNT9zuFPG1BNtYoypiNCJQx1KeBNhI4o
 QQ5ngi2eO506BhH7E9bBIhvdMehkN2i6g/uFnF7hRPYyjWYvebqPcWnjrVBcFNDlH7Ab
 wQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779430055; x=1780034855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0GxXWPb5b7IE1WF73BuquobJeXJY1I1vTx7dwyLAryI=;
 b=ZDkqvCVTIX4CrtpMMndrYQG1z5f/3u7Of3VwSnDfBEvizI0FIvWEJvNOMTQ7YZ5Dg3
 JVmCan9bxp5JaqztPdm7/YlVfiGyUU2rVe1dnO8CijmHhD5xvE+bnfwWv/bzSx/LU9tK
 WgZw1s1jxJnqBKqkZftCkMDZrpgJGxtYJzD9oggf36iEeMCb3XynO+5gKMB+5s64pwK/
 wEimbuelY+BufN2nA+tPoqjMa2ZeLdf1IJXf8MoPW/D59x2hY7nPMZdIfti/9/hH/LVX
 hl6Wq9tuAGtDFm313u8L6b5pKWQt/OtWHuSOgAlybXh+1KSZJF1P/UvwXls+Mw+M8+Ca
 v7tA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8moUVSIfgvuZgI99OUON52lhEwCY01SFTJzzSFSskyNeR52+6+8bnkZXA8V8ZWc9b9Ts1CKzgviO8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdFl1TB1ukF/+ebZFFj2wyR8URouPA3kjQTrFErj0AUoeRnZ9l
 QiwrbhwVRjzApHjBOSUuxll2rL2iQ/AQlTl7rTFCsDqdLJ69yeviAqVJ
X-Gm-Gg: Acq92OHDxttCE05jJmcekhB5Cc2FgddcCY1Po/so3wV8eOi7nvnn6qDuyGus2i8v6xy
 pfwwzq1f8TB8sM8RegIBJsE8DcDhvCgokrDAJRLcQKGfg7jf3immvUxkpoqX78RYOC5Fouh5mhq
 43/U63CHWKURi9pFOJ59rvuzIi6ygk+YMLnNES/Qb6AkvOt/wJB9GKerCqIiODE+6nsRmAASdj/
 RAPArF4by9z4HjOiOraCsVsuiatG4YPD60sNU6JTxGl9LymCW+3fX0FHr7KZAAKk+9BqUBFuLqu
 estWy4LaOA9QiTyzKaeLh/gzc+KWxBnMuiQRIdD31Uz7ROe4y2t79ms5XQTDksPTUpLBepsxO1X
 KoDz5GMiAVUWm0ij0D6mutrGXFNnZWIb7jKhzrzjXS49u5cJBn4myw+l2dESHv2EXob7pbkFpHU
 +MogaQaoU2DlNv4cjsuF4mZiuVmOLFBA4ze8dnfiI4awD9CJn2/gtkJXDJ1WHnhwnlJQ==
X-Received: by 2002:a17:90b:270e:b0:362:e826:cefe with SMTP id
 98e67ed59e1d1-36a67697a77mr2327977a91.23.1779430055466; 
 Thu, 21 May 2026 23:07:35 -0700 (PDT)
Received: from radxa (122-58-25-162-adsl.sparkbb.co.nz. [122.58.25.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a7212aa06sm428572a91.3.2026.05.21.23.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 23:07:35 -0700 (PDT)
From: Graham O'Connor <graham.oconnor@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Graham O'Connor <graham.oconnor@gmail.com>
Subject: [PATCH 4/6] arm64: dts: qcom: qcs6490-radxa-dragon-q6a: Add regulator
 supplies and disable EUD
Date: Fri, 22 May 2026 18:06:43 +1200
Message-ID: <20260522060645.4399-5-graham.oconnor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522060645.4399-1-graham.oconnor@gmail.com>
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 14:41:04 +0000
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

Add missing regulator supplies for qfprom and the PCIe controllers.
The qfprom node requires vcc-supply for correct eFuse reading. The
PCIe controllers require vdda and vddpe-3v3 supplies for the PHY and
connector power rails.

Disable the Embedded USB Debugger (EUD) as it conflicts with normal
USB operation on this board.

Tested on Radxa Dragon Q6A (QCS6490)

Signed-off-by: Graham O'Connor <graham.oconnor@gmail.com>
---
 .../dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
index bb5a42b03..4003837ad 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
@@ -1093,3 +1093,23 @@ &sdc2_data {
 	bias-pull-up;
 	drive-strength = <10>;
 };
+
+/* Provide required regulator supplies for qfprom and PCIe controllers */
+&qfprom {
+	vcc-supply = <&vreg_l1c_1p8>;
+};
+
+&pcie0 {
+	vdda-supply = <&vreg_l1c_1p8>;
+	vddpe-3v3-supply = <&vreg_bob_3p296>;
+};
+
+&pcie1 {
+	vdda-supply = <&vreg_l1c_1p8>;
+	vddpe-3v3-supply = <&vreg_bob_3p296>;
+};
+
+/* Disable EUD as it conflicts with USB operation */
+&eud {
+	status = "disabled";
+};
-- 
2.53.0

