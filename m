Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4045E606A8D1
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmO8pI+9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 309EC10FBA2;
	Wed, 28 Oct 2026 11:19:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B198510FB74;
 Wed, 28 Oct 2026 11:19:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0EC5A60267;
 Wed, 28 Oct 2026 11:19:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793186355;
 b=ijaMYTEFGzK2f4TER2x+LHt8z8+I9z0IHeKO+OMeMBEg7+wLUGuJP6CALOse6S1QG1Le
 RGy43wErfV+jU2KtBd3z8MoZrXCT7nCVntU/AntDtg5OANSGXSq+8p6Beo+mZ4tSzT+QK
 Y2UZ+2PZABZvxPjkCfdYED0xT7qoGCXro6h2U6k0M6iXVoR4J8copSHN//W2EEZxOkk1/
 IwALQ4TJznWUrHuw50ybjsnNexC/D+2TY+0ff0AMeTgYkiKZZ1p9ncPLpc0Z2xVN9JROY
 HVLUIU/EkHP4kbnsiw8+veuPDbw2L07AYKospztrWz3zhz/cP7uZvfydgwYOhNqd+pw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793186355;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=siDHJNCTopPCSRKzCL5cJLzJZg1AuYQ0QITbIwpTbio=;
 b=1Jsz7Wu/69sOSKwBBejDC6dqzlPlvovdBBC+MVCgR+b4zPjQKxcE+NtexQMWrXPcPoEj
 L0Tx+EkDWseEKgfSJxbuws466CJxtvAZ7N/RZORVCYjDJ2i+WMc97jzAcUhPGjBwvWfGQ
 +3SRFSX86bDNLwvzSxgjyVdUK+qIoP6sLsh24zfZgnVlvZQJ00U3SvBA4JivbKJjZf73n
 Wake/HAO6M+mGLyJvWSE2pCUYim4sHKHkLJ+pfDvlio+tqdWtd6N5IPj/UxmVNHRSPF6P
 0+bPU7elUmETco6M8WPWc7nb7IwZt4idnMkwMu2LR8Wd4Ye13xRX/nc0+nwzOyza8MA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 659EF1F031E4;
 Wed, 28 Oct 2026 11:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793186355;
 bh=siDHJNCTopPCSRKzCL5cJLzJZg1AuYQ0QITbIwpTbio=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=VmO8pI+9XEysYnVPcbvvMQ3zwQX0Mrijloscy0v+EgLCb04WLWiit3y2yn3hY3gjB
 xiFyCyjb3AMhoRxX/8EAU5KG357rhVcaQKsqtN58KY8k+7DL5d44mbanGrHmTHntf4
 8dQqp0eyvJ06UdkVyOBIfNJikoyqOmu7hVNJvDmKtaRpdk8x01pKMqVLzTMObav/bN
 +UCqd//ZEAavEiloGr93lbgyyp6JaH3VfJm2smL9a2qqYG9CzpHPi2tzjhlFBTWsFh
 O5nlcd/DoinnkRxTPX/PM+lvrn0BsbJ/27QuDU9zRYsH4sYOfob0rTUvNfVVYrVhSq
 zmLtCeEOouOGQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id DF6D345427;
 Wed, 28 Oct 2026 11:19:12 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay
 <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 28 Oct 2026 14:17:25 +0300
Subject: [PATCH v6 06/11] dt-bindings: clock: qcom,a53pll: Add MSM8952
 compatible
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261028-msm8952-initial-support-v6-6-e07ddd8bcf4c@mainlining.org>
References: <20261028-msm8952-initial-support-v6-0-e07ddd8bcf4c@mainlining.org>
In-Reply-To: <20261028-msm8952-initial-support-v6-0-e07ddd8bcf4c@mainlining.org>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org, 
 Muzaffer Kadir <muzafferkadir@mainlining.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793186351; l=1385;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=BrzMm8QIgqROsRwWhO5mUK+pBiKnEr9sw/uWcqoVjmc=;
 b=wJUCS0E1QC//bgwIhJ3rv8QS6QJhatBac3eV4Z4kJIhHk3lq1qq8Wv76ghgEB0Mch99FNWQ52
 fC2U63mJeS7CQN+r9MsE/3AZPX50PJ88XHH6JWDM1dfngE7vz67tdY3
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
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
Reply-To: muzafferkadir@mainlining.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the a53pll found on MSM8952.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 .../devicetree/bindings/clock/qcom,a53pll.yaml     | 25 +++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
index 1eec77e75a0a..4abfaa24bc71 100644
--- a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
@@ -15,16 +15,21 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,ipq5018-a53pll
-      - qcom,ipq5210-a53pll
-      - qcom,ipq5332-a53pll
-      - qcom,ipq6018-a53pll
-      - qcom,ipq8074-a53pll
-      - qcom,ipq9574-a73pll
-      - qcom,msm8226-a7pll
-      - qcom,msm8916-a53pll
-      - qcom,msm8939-a53pll
+    oneOf:
+      - enum:
+          - qcom,ipq5018-a53pll
+          - qcom,ipq5210-a53pll
+          - qcom,ipq5332-a53pll
+          - qcom,ipq6018-a53pll
+          - qcom,ipq8074-a53pll
+          - qcom,ipq9574-a73pll
+          - qcom,msm8226-a7pll
+          - qcom,msm8916-a53pll
+          - qcom,msm8939-a53pll
+      - items:
+          - enum:
+              - qcom,msm8952-a53pll
+          - const: qcom,msm8939-a53pll
 
   reg:
     maxItems: 1

-- 
2.55.0


