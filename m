Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A040606D81D
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NxUNwHI9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C79112364;
	Thu,  5 Nov 2026 10:55:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B9FD112353;
 Thu,  5 Nov 2026 10:55:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B9CB60D93;
 Thu,  5 Nov 2026 10:55:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793876107;
 b=r8/0ZgQ8IvVY60MhsBFnNbrgvdqsAl1Y5JuIQ6DqTlf7XkDK9ue8moos1GrdVeWhebQd
 zmvuCAi1gzuLmlVD1A4yh56eC0UPGXcvw4oUnhaQauDQ+BU2lst7v5QB/OdviAWlrHk4d
 9x30cWMxEz89tr+c9P3xnFL5OTXFvAVR2EKi8zH890MZ/iAhgqxe62kGRuL9iycwewbgE
 SRJ9IXiDLp2HwaVqTEzjqy0p0FkomGJ9WshkCoqXaBTdHTR2t7dAMiAoQXD3FDD21kEg1
 aJuU6LC6cnASsvq7+7qywiDXuvgLAXxCNvWKR4NzekiqXQCqRu1r1L0YyrWdeKuX1WQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793876107;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=eqtig5fCjOjVJrrKZpZL50g3TFZKrPCAhqPARLo2Gk8=;
 b=md74BaCspjGeRD20aRu1C2NUNKfMdNhGmFyR0ZcNS3JgULTaPJUZG1646TkOydRq73So
 xCwivg6qfpPELTxtWwuWIibGAUnT4VRn1UPWr0nV/DAuyA3+pv0RKbXngMIPfZk/24U6F
 291GKzND5eBm02mlq7mXHqlcMMLbJbwKqMpp7hveR511kH0beJV4ANA+cEen/MMxlTYAk
 s1JD22Dgtg4VFmgh7PY8PXWCqXh1xLujiqY6T55+x05v3Pquk6h8pzW7Mv7NWf36LcsTj
 aT5YFqYmg2WZy/OJIGsoJgzYSeZOgV8g8GDkgH8ztqk3X4OS2M+NUaHJetaNcKZs9Cw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 4DF831F00A1E;
 Thu,  5 Nov 2026 10:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793876107;
 bh=eqtig5fCjOjVJrrKZpZL50g3TFZKrPCAhqPARLo2Gk8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=NxUNwHI9rG2DOHB6dc0gmcOAGpPGgDh96ebvElScVF7uikeig4QhmpPfnAh6IGZsh
 wnMHq1cPgc3VbsdmcP/IG76F2q7bcvE3TJzqzZO3sSl2iwTEKtqAPo79n6hQndaE8S
 iSOIfB0b1SKQNuuyWMK6zo5DqnTNqBhdS7d/o3esYuPutvpkTc6SXgHX0kq2ZtlD0F
 htgQ+8JKT7Md8z6nZ/ZS2A0B/UWQE5/tXD05MJ59TGWuQ2ZhFJJ+rQz5KslpwiEH+t
 SaaKlJxNEwmqVIL+WMJhszCEbWIlmcjN/AF8weKToWK4REo78uv7Qv27OEc21kvi7k
 WConI5rGFtI3g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 59BD9471F0;
 Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay
 <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Thu, 05 Nov 2026 13:54:11 +0300
Subject: [PATCH v8 07/11] dt-bindings: display: msm: dsi-controller-main:
 Add MSM8952 compatible
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-msm8952-initial-support-v8-7-311ae8e8f14b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793876100; l=1230;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=tE4ESt6GLbLrou2AMZ3vpaz7ObZA7wbkAMXSAYph8E8=;
 b=yD38J7QlQ5YHfbQ0SdqjEMcRFJ861/b4IajAwjl3suzukhe2Rs+U3loQHHNsJCe8NLrd0Wkoa
 HWoFzkab6toCwCRNkGusupAbdieF7EygivjjRfpXUAjF2KLho+tKU+e
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

Document the DSI Controller found on the MSM8952.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index e4fd1cbbd4e0..8b352380827f 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -19,6 +19,7 @@ properties:
               - qcom,milos-dsi-ctrl
               - qcom,msm8226-dsi-ctrl
               - qcom,msm8916-dsi-ctrl
+              - qcom,msm8952-dsi-ctrl
               - qcom,msm8953-dsi-ctrl
               - qcom,msm8974-dsi-ctrl
               - qcom,msm8976-dsi-ctrl
@@ -271,6 +272,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8916-dsi-ctrl
+              - qcom,msm8952-dsi-ctrl
               - qcom,msm8953-dsi-ctrl
               - qcom,msm8976-dsi-ctrl
     then:

-- 
2.56.0


