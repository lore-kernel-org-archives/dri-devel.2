Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C7606A33C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jcQsY203
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EAA210E199;
	Fri, 20 Nov 2026 15:52:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6417E10E13C;
 Fri, 20 Nov 2026 15:52:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 29A184676E;
 Fri, 20 Nov 2026 15:52:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795189970;
 b=nlPnMBO3A24Z10DDTDIia+DXYJok69ljkoj8BEZBsenXO9FoT+PJsmsUEqaVkFM2p34z
 s4EjT04dgOqrAyFUjsWcVLOjx4DyrtkznjS9hYdLN2yBmrLPLZW1OLnpltraTJ89xYKFy
 Z6pVBB5eXjn8DJhu4u8dSGnopzQZoC4o7Q1Noc2w0jfw9+E44JsmjvrzpXww5m+QtYyXf
 okJuBTvmrb7RkFHJYmIlMA7AJfUC2ZbeFnWLg/RZc5MVu3Fnt3Unk69v44ZbOUxZMiTWe
 SAtj/1nZzDgs12w6LDwExlrAsFEMyoM60N+bfj1yU8N5E9uZrVngJwDBNc2N1RJJ0ew==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795189970;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=+99cmFsfXOULQ9f90LxW+hyZsbOUVRXMjmKn92M1d3M=;
 b=xDkgGUuAnFLpORZ/5nT14TTFoRdzgzKr5caMK69VtDvup4wcCpfxmkNnfVD4MzhJL1zM
 NNzCj59Lf2lQ4Jdwpf3vtQ3musl1A3YPTNDHSK+L3xWys2Got/AQ43IAtcwbW3GRTm2Jb
 G7AGJld3+peGjqdJ8tc4fUCuVfT1ZoAmsJBl24h4VWTBDbDpC5+0MzoIB1jALBZM731xt
 m/reZnj6Yvl4gjYUsJlrli0ntMP5qDtIfV3m5/5XBiaDqAG6fbuUg/5JVYDHCyULaMTH/
 5Smg0kaBRBb2oBUb2m7f3bSrvRVpftM4TXyD/UWYaCigropuyjjR/0ed0IHXFqiqudg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 2FEFA1F000EC;
 Fri, 20 Nov 2026 15:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795189970;
 bh=+99cmFsfXOULQ9f90LxW+hyZsbOUVRXMjmKn92M1d3M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=jcQsY203WZzJ4Uc5wjeDeevGqTkI51zJKeynkS+t8/U7QV+Ds2fBi/3RRQfyWqdEH
 dCZHGh0WFEMVy079neVWxvzel574MdeihaAbzpukGKb1d5Dn6YTmwAGnZTB2pQGOyB
 6h0f6ren3x8CcWB5/+Kwmg0FP1S/8xE+FbW4Nw9vepwCidX6GkQqg0AkNlhsfV/nib
 DrC7Deum7Idb0aEVLqK0Db9fBtWSG8pYYsD/pkOK03r66v51f+uhqg05w/DLgGroNo
 /5u4XxcEvaijx6V/rVgjY9Midko0HmYGyZOKuuHUiPgazB1Q2+rwtsRnohkALNIyd+
 td1A2an/1kAhg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D259049927;
 Fri, 20 Nov 2026 15:52:37 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay
 <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Fri, 20 Nov 2026 21:22:37 +0530
Subject: [PATCH v2 1/2] dt-bindings: display/msm/gmu: Document Adreno 829 GMU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-molokai-a829-v2-1-c63c268d5ab3@yahoo.com>
References: <20261120-molokai-a829-v2-0-c63c268d5ab3@yahoo.com>
In-Reply-To: <20261120-molokai-a829-v2-0-c63c268d5ab3@yahoo.com>
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
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795189956; l=903;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=fWx8B8EVRHaa/QjmI//OdB1UeHRHRMAyCbcwF2whEXA=;
 b=1bTZmN2D/D8obhEtn5O3YNXSXlkGtc/C3KCjY52B9UBG1bJTa+MOLZDfgjP8rg2gPPzhmKicK
 E6DdQPy65G3BFBGBkSGOqDBeh6lcYwIRR9D1Habl8tBcXgepoa0ieEf
X-Developer-Key: i=venkat.yadlapati@yahoo.com; a=ed25519;
 pk=e8KStCtEMvUP1Se/riB/KVnDAQFEVR2Dw2PcuA8/eME=
X-Endpoint-Received: by B4 Relay for venkat.yadlapati@yahoo.com/20261023
 with auth_id=1303
X-Original-From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
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
Reply-To: venkat.yadlapati@yahoo.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>

The GMU of the Adreno 829 found on the Qualcomm Molokai (SM8845) SoC uses
the same registers and clocks as the Adreno 840 one.

Signed-off-by: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
---
 Documentation/devicetree/bindings/display/msm/gmu.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 07f0e547b43c..2599eca08a36 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -337,7 +337,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: qcom,adreno-gmu-840.1
+            enum:
+              - qcom,adreno-gmu-829.0
+              - qcom,adreno-gmu-840.1
     then:
       properties:
         reg:

-- 
2.56.1


