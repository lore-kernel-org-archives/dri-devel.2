Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DE7C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 03:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 081E010EFBC;
	Wed,  8 Jul 2026 03:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SV+dAP+h";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K7S8Xss4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A42F610EFBC
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 03:58:57 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6680cE5Z1197367
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 03:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S6d3uAJoinnsOl1/YcHCszQu6juG1psUOCiIWOtRi+w=; b=SV+dAP+hn2aK7wMI
 L6R38/BT4XrdocIMc39s1kXh6whQzQmOF/YuxxOVmFlwq87AVizRD/3XZE93pZc8
 PcwI34dSCReN+OG2KG3vp/BGzXD7HexD+3kqqnOQax2LzI+9AGr7JJXN9QRlie+h
 NM1fl2maAl0KomVHdzdIuSWYmLMfxQbU29/b4pjHiBiffM8yMLa6dH/kIrIxx95w
 2F5eXq0y65DBABdYoQePssIyTeH+eQncC6XZuIs3jdZ4EsTjWeA+ndwdqmQ+mUHk
 uczvvFIs0+TwgTqcvU633oE+Xg+YW1Ryd4jpYbJAdlHbrN05X0TSWx/l5+oBtVI5
 3eOlRA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9c6a8mhy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 03:58:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cce870a060so6605955ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 20:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783483136; x=1784087936;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S6d3uAJoinnsOl1/YcHCszQu6juG1psUOCiIWOtRi+w=;
 b=K7S8Xss4FEDZO0U/PCD9SPnRd195zDCrcO1tzUegrEFRsfO+KhnRRTyURJPOrUE3rz
 Tm6SyNb4fjE7ahunek496BY/LD53+59XRBO48Kp10+7AXnAfjRMhapBZ30NpOn3bqkFg
 rup4jDg/3UZZR07V79m9QiijDAsv13wh9A5qdRarNCWnJ/+H9SC2eVPBu2xPklziAyoH
 x8DcyfurthYLxeAutVDpc2vqpdwMcHaHCq8kuJyaK/Z9zE3tRUWFZb8nRFBZf9GQzfAs
 c3LRnA9len3Nh+C+47GQQO50T98mBPc5gM1RbyAeTchV6+NfdM7YP0rinrLwcQPtWf32
 Am8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783483136; x=1784087936;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S6d3uAJoinnsOl1/YcHCszQu6juG1psUOCiIWOtRi+w=;
 b=BQwy0g2+WjmAHEThrozOXGv+wGy0wFST4Ma7+OXjWb8HicjRmulKweP1lPI7rvZNSG
 rzt6ONpE12tMk3ExzpnOiO6mNZA2bNcARHTtuHe+9Vknt4syT2FP+n1O2XR5KdvVOEHt
 zPkEchaHUev3PRZBlZiJI1l4EruI8gT2WdeIvRzNF9eYleMdDgilOWstr/X72Q+Vx6Kj
 Do7JvVPV0GqlFnooGkV5QKVtnRGsAOjgYCtmePoF1gXBH7dyGyoku4JQEuZAzOBEx86S
 oIHluxvy8x7cFwr9G6SEbQZGxgwjIRqD2mPJ/xFAPjiyqQlY1bjwXUMxpLN9Oddb0voO
 GZMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTaNpSQp9rEUvrils77zNFwtt8MIHBdebI/vTr+p9DRujvqlZYhELqrjpehHTt69NDl52bjuCmwOo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwH+gd96MDaV2k9DfG7ERRqnGmnWZEKqMPCjR3RX0WFjF+nZk8c
 GLRNbeZvL1s87GZxmXjdaDdYiPDOOtIJDHeyAzyjIDJARbZux1S8LmjhdKQw5XMn5iO0qOD1IYO
 XwSOJy3YwmGo8UcBr/K9cznPgrSZgIfh6hPICfKoSLnG6v8IGaNKgnP1ZSfh6UyULpS4+pv8=
X-Gm-Gg: AfdE7clJTDWNxgn2huy4+tkHjmYhIkRbOshecIHi8DXuf7zmUhukfgseTbN4KNk+t5W
 T/oX+VcGbIGE6IGXNroxkEo+/3Kye3wF49CE7DjFIZjvkNcIWOr4GU5nvQ1rgmHBb9h61SbCMhT
 p7rVjGhW2EhHw955AKdeS7wwWZjDqFUqP3HhjqUg98PKjvoe5n+n9OT/fa7Z3Hcs7mGqErxQOCU
 JxcChKfyX6MCgsHUYryBd4ks/Mn0VujomB0wAMGMPuGfhV82EXC0/vRXtU+8OkWHTYI2TBYFjc0
 Yt2uVJojyuaHZqCMOdTS2LH/4WXkvxA3UoXEIxeQ8w3/fhN2chrSczqzbKolCX8Y/WA6cq0ZsPh
 xnxxKB8FvOpD08/i/P4ffHnE/BijETcebIcNqyKiVBszk
X-Received: by 2002:a05:6a21:4cc3:b0:3bf:a4c9:b054 with SMTP id
 adf61e73a8af0-3c0bd0fa859mr691996637.46.1783483135645; 
 Tue, 07 Jul 2026 20:58:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cc3:b0:3bf:a4c9:b054 with SMTP id
 adf61e73a8af0-3c0bd0fa859mr691965637.46.1783483135199; 
 Tue, 07 Jul 2026 20:58:55 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm14487136eec.3.2026.07.07.20.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 20:58:54 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 09:28:32 +0530
Subject: [PATCH v2 1/2] dt-bindings: misc: qcom,fastrpc: deprecate
 qcom,nsessions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-dup-sessions-v2-1-da40f9c98a2b@oss.qualcomm.com>
References: <20260708-dup-sessions-v2-0-da40f9c98a2b@oss.qualcomm.com>
In-Reply-To: <20260708-dup-sessions-v2-0-da40f9c98a2b@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, devicetree@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783483125; l=1078;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=jcBb2YDdqWv1otYxbn2Wff3itz+faGuhvh2N5yqzuIU=;
 b=NIU9Cph1kKEnebQNUvIuVcLjJmn8FM9KtYiCPWPf/yp1KGdMqb56gZbT4t3595WnzcHUhPLvh
 TAy6/+eaEwQCiFJLNN+7WLoMz8kDrC7rSQpFMEh2TiDFu/5se8tdG/u
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDAzNSBTYWx0ZWRfX2hvf5/46KWSL
 LfCCates4o1/YEpzDTukIXX72ypDJk/nJTSW190YWD654EeHBdW4oBT2N1kV0TLpY78LTIh7His
 ZO0KtEZGsK34sSUhNhQkBFS9usNGkbB5nixa37MT5JJnr00aah6s2vY4NaeVsBQrGZN5czOCpBU
 kX6Ig3wJnXyRhXwE71+4LL6IUOkhBaibnSYIeXOIILKxn5lzVScbXQJcp9drR8wU9mQh3kYaj8W
 CyumG1vUob3SGrvghv3jxCksYrYcA+/MidU8xYOa+pmZ9cGloggMS0O/XwM9xv325xP2uazcxRw
 WmyhSXEYZqAycXdo32u60slRt7evA/JYA/sMddo2r3KeUJEcq+LRe6jFD65ARev3BmBd91PEhVV
 DrDwJy5Yan53ecapTMbIi97G1zeBGyftB5G67epx2d1xHTU2M69IIvbtZinT+lNtUiS3t+Bwnyj
 Wfmg+yETSH6VurAoLKA==
X-Proofpoint-ORIG-GUID: 4oYPvj0rU1j4kVSw0LJyctFAnSFHFEzb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDAzNSBTYWx0ZWRfXy1TCFIg5uA7S
 xHGRrP8wPpRkUC/CqKFK/R5A/qdSFfKpZwaNsJRkCrebz1UahGJpYc3FnSpgVCPUCmsuVn4Dpk1
 7SdUPrLN/FFBpZAjSG/Rc86j+pvS7LE=
X-Authority-Analysis: v=2.4 cv=UehhjqSN c=1 sm=1 tr=0 ts=6a4dcb00 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=vVYqS5fJ2MeE6r2tohgA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 4oYPvj0rU1j4kVSw0LJyctFAnSFHFEzb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080035
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

The qcom,nsessions property was used to duplicate FastRPC sessions
inline during context bank probing. Session duplication is now handled
at the driver level, making this DT property redundant. Mark it
deprecated.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index ca830dd06de2..683989c468cf 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -96,8 +96,10 @@ patternProperties:
       qcom,nsessions:
         $ref: /schemas/types.yaml#/definitions/uint32
         default: 1
+        deprecated: true
         description: >
           A value indicating how many sessions can share this context bank.
+          Session duplication is now handled by the driver.
 
     required:
       - compatible

-- 
2.34.1

