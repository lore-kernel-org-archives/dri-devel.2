Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131DF606D814
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SUD6K/hi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4AC8112359;
	Thu,  5 Nov 2026 10:55:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8579211234C;
 Thu,  5 Nov 2026 10:55:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6539F43EA1;
 Thu,  5 Nov 2026 10:55:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793876106;
 b=YAdJiYRy5lVASCh4aTUXzzGhodD2MSNxo+tQbNdqojcBrVm8NbPi6JiSGWzRYd12kkqn
 V3rCXx5Bp70PtZN6NnRNiFjQIanPv96IZYXYwZX91dalaU64e/Q225cZVWZtogtt2s4Zh
 BgDYCJQOOINtsFw/YqPFl1/lhnUJVEd5h1tPfQ3yexmRXM0W5c7xM3dkyOFkKs9veb4yp
 WCRhk+0LWG3gUyhDl6sPhhmePx3/+ucpnifVdXoAt6q1WvSc5XSq1XNCuAakVwaABg+Dc
 klFtMjCceix24FhyxI6WATlNE+LviwlSfnJ5D7OBLCWU/AE19hHCZUbNB3caUt14hVQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793876106;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=mf3DmzKcqwpeAnx0872mpsmdtAH1W+pG/zhvLz+lRJo=;
 b=UaUfsNK+JZ1kd/1hIeIk8qcZIgviR/PQvRegbGXFM/U7e6yQlH3qlXUdmMJXVqH+mpAi
 nzUYklXnzP4YEDPDqgrG/vR/y8DWas7NilajFShwtiiQ4138n6NJO9zt+CzSk9HZzp30J
 vD4mSgjDKDokU5eW7cUTXNibUhGh9HEseuQQZGEtZ/mF+tN8XZ/5bfm8LQpsAfFrnBpXB
 jJsqxu+mXsYD1V283SzhSzwAhvRUu/NuL0uMSyjkM+n0OlcGP92C/JEKfUjqoaWHEbRvj
 Io7SNvnauz6z9D6gKlOZXkZEOnMtw8oOBf5bY5S/zMDnTsIuIPQoHacmwL8wGIl+OBg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 6C8911F00A22;
 Thu,  5 Nov 2026 10:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793876106;
 bh=mf3DmzKcqwpeAnx0872mpsmdtAH1W+pG/zhvLz+lRJo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=SUD6K/hirZTl+t0jdIx3RstJgeWxzfp8CHplQxGRAVjqC2QVeuRO+KaHlIiehAp93
 yliaFgTgAC2IE+ph9xeMQmwt2oOVAtRsbf/7a+KiGLRxG7He3XDlR0skhR8i78R9jY
 k5r70WW4kFAaerrTMldo7aZUshmcW2otdgbIj+JNn7bdZhCvOjB+ZAaOu7CILWDySD
 lF/S5q6KQYMmxKH8FTJa8UNOBHsBi9avHfR2a62ucVZAhb0wxFxjfR8vPW0r1U4Tpk
 WwMmBVyFaOt88KTQbGIyhGSQfCPU0I9BjrLUF3ZrNm26id99wf4pVPcaOM9u2j4gdh
 +TkeEPUTQs/Kw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8C26A471FC;
 Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay
 <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Thu, 05 Nov 2026 13:54:14 +0300
Subject: [PATCH v8 10/11] dt-bindings: input: touchscreen: goodix: Add
 binding for GT970
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-msm8952-initial-support-v8-10-311ae8e8f14b@mainlining.org>
References: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
In-Reply-To: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
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
 Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793876100; l=1656;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=8T28pJ+j3T2BfrA/4V/vCpSnX+IH26SQiXSCeXTVAPA=;
 b=g7KDlMPaWyh299ODCALGQrB2v5+x2XtJVpCgL8+3cwaIgFNZl2pjckMc9/QfI/jUd/dT0KCmO
 X5ExalfRhKPBsQnEhfZZSxQy1Ri5XMv9oxYCfAUnse10OxM62KlGmon
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

GT970 works with GT911 driver, document it to be
used with GT911 compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 .../bindings/input/touchscreen/goodix.yaml         | 35 ++++++++++++----------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
index a26a54d63a1c..4be2c137abd7 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
@@ -14,21 +14,26 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - goodix,gt1151
-      - goodix,gt1158
-      - goodix,gt5663
-      - goodix,gt5688
-      - goodix,gt911
-      - goodix,gt9110
-      - goodix,gt912
-      - goodix,gt9147
-      - goodix,gt917s
-      - goodix,gt927
-      - goodix,gt9271
-      - goodix,gt928
-      - goodix,gt9286
-      - goodix,gt967
+    oneOf:
+      - enum:
+          - goodix,gt1151
+          - goodix,gt1158
+          - goodix,gt5663
+          - goodix,gt5688
+          - goodix,gt911
+          - goodix,gt9110
+          - goodix,gt912
+          - goodix,gt9147
+          - goodix,gt917s
+          - goodix,gt927
+          - goodix,gt9271
+          - goodix,gt928
+          - goodix,gt9286
+          - goodix,gt967
+      - items:
+          - enum:
+              - goodix,gt970
+          - const: goodix,gt911
 
   reg:
     enum: [ 0x5d, 0x14 ]

-- 
2.56.0


