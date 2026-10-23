Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AEE606A331
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mG8PTwm0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6412210E59E;
	Fri, 23 Oct 2026 08:49:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C2710E59E;
 Fri, 23 Oct 2026 08:49:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 85034407EC;
 Fri, 23 Oct 2026 08:49:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792745343;
 b=FACpQTkByvHeVDtnKCnaTsZ1wWtU9KM1hLZ1iLvoBpfjL5vk5NS2RWw4H2EoREzeCauR
 1yhz/TAFYphuEr6JAGnfmPTMEqGqzzLjT6Ts2oT3P8P77gl5miYbvm8rgH/KOm6udqzWc
 SDFhEslCE/f7hVuIYXVUK9JVd5KJlL7WIPzZ0KwYdu4duclYOr9aQ/L8C12Mr5FgWsEhZ
 Q0vHeMBv19fX3gUEJFXbAeiMS5kr8indj/yLr8Ma35IqwQTX62jajFSB9bzK73TeW49gJ
 Lsn4a2jV+KlS8aH5gQ9rAXu/F8MEkqdED8GHWyVQ1kEty3ROvrsy6pmFP77gHg9j8bg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792745343;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=dUrTRiB6a6KjKPKdRXzNwQlX1C6Hobxw+2BixQH+gvY=;
 b=YtsXFpMR/fEeI8BvZ9oQFwOm//LZ1dbIJinN5j9OA8Q95QooB6mDfczNIobs8AjfGM6P
 k1XuOdDICPRerP/fI5UKDvsdu2eAvSHXj4GMaarOEqOnBHSFQ4Au0Aea0a1J7CKPPms7X
 hSghAk9XX87640Vm/rrfs2SLgJt16GIUfn8rNyJ6VK1FmB8edjsWb5Avxu4TT3Lorn6Fh
 DqvYNYSfIRrBFfT0w3ZR/XnfV2X08PnTPMSpkmkAWfCaiHcXXtFB/kTb3XtD82h9yESCR
 eE5+8W1hEDKH1H3X7DrkZudxNRr4RkdsEYt5d/e7NL6DsRGrnH1Ob7tz1aTDAAyO5Pw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D8B4C1F01828;
 Fri, 23 Oct 2026 08:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792745343;
 bh=dUrTRiB6a6KjKPKdRXzNwQlX1C6Hobxw+2BixQH+gvY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=mG8PTwm0IVk7JJb5FbmuAbAOOp4usNx8EKB41xsZUp0medimcwsIUbGrvfQnCkDac
 W3Bj3chv2H4HML1BpqUQoT1GJX28zwBxFDiOY10ZXZRRMFkxyCDwcVDZmsWoNBwx93
 L/geRrm5jha5xySC/COjRnJicWBV9PpCanRDbQm0qknYet7nWGBm02GgxiQw06tchB
 uVn7oQa8WkfVV8cPTcnZo4aQqtVTAFgnE5Au2jA/5C27ZwV4KGEkhgz7+Tfb1yVluV
 CGVDvJib9OELc+S4flCoJsd4NouEqki6EDxCFFmbZSU/nQR8UDRaM5CM5kioj4fcRV
 fQ73GLfD2YjaA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 695B54442F;
 Fri, 23 Oct 2026 08:49:02 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Fri, 23 Oct 2026 14:18:59 +0530
Subject: [PATCH v2 1/4] dt-bindings: display: msm: Document Adreno 620 and
 its GMU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261023-adreno-a620-v2-1-1d654c3f52d5@brar.si>
References: <20261023-adreno-a620-v2-0-1d654c3f52d5@brar.si>
In-Reply-To: <20261023-adreno-a620-v2-0-1d654c3f52d5@brar.si>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ishu Brar <patches@brar.si>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792745340; l=1758;
 i=patches@brar.si; h=from:subject:message-id;
 bh=8eTnNvhKpEjMR4UE06ag4D//fKmp89dOdFVVH07JhJ0=;
 b=xhQgn8vi3LV6G+qSWdk/hwWPT7jrt4b65B+kfX3vXJIW1u7tq8z6+9FqiXZfCfoZZrUiEo+5w
 36Y2hL1QFVmB/zv8pk0gyvSggjgwCTdVFBjIP2jYqpj2oFzS5OMFMD0
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
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
Reply-To: patches@brar.si
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ishu Brar <patches@brar.si>

Add the Adreno 620 found in the Qualcomm SM7250 and its GMU. The GMU
has the same registers, clocks, interrupts and power domains as the
650.2 one. As on the other A6xx parts, the GPU clocks are defined in
the GMU node, so the GPU node has none.

Signed-off-by: Ishu Brar <patches@brar.si>
---
 Documentation/devicetree/bindings/display/msm/gmu.yaml | 2 ++
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 07f0e547b..3478adebd 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -217,6 +217,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,adreno-gmu-620.0
               - qcom,adreno-gmu-650.2
     then:
       properties:
@@ -238,6 +239,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,adreno-gmu-620.0
               - qcom,adreno-gmu-640.1
               - qcom,adreno-gmu-650.2
     then:
diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index c30de7feb..cf015fdee 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -435,6 +435,7 @@ allOf:
               - qcom,adreno-615.0
               - qcom,adreno-618.0
               - qcom,adreno-619.0
+              - qcom,adreno-620.0
               - qcom,adreno-621.0
               - qcom,adreno-623.0
               - qcom,adreno-630.2

-- 
2.56.0


