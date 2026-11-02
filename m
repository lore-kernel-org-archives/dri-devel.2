Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336D4606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UH5DTolj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=byztkGvh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8122310EC1A;
	Mon,  2 Nov 2026 08:31:49 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B407F10EC1A
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 08:31:37 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A23vILB3324667
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 08:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hnuqUzzjgSEBIaiHp/opE7urPU3XKVrRGqxwgy1tl/U=; b=UH5DTolj19deutIT
 zqV014fRre0CTOATsmQMidOF+cXwsQAUpJLZyWL3MMotWOYCfN2GfteVrwCBENLn
 IcueiJ/blXe5WsJ+yJmHS0dtO0x3e+CWP5T05BiyUA3jJt8hX6lxrGCfm3MsEBbn
 2OooUqEidWZMeSdIr/f7dMDHNOUmZuzKOm3REgfJ3bAxyHZtWpCp+PopXmDooozC
 BIkvlLelEZhEtJA/dFt3B1NB92KIBU3x5TfvMCrR863VSbgi6CFZyFhn+HxNEe9W
 6s6LvuhSBwYD6FQXS1H/CWE/NKetkc9b4CkhG60DRS0/ipQ8J+sgZnSxEH+tMI9F
 /w3xug==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6p2w9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 08:31:36 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8a08e315b5cso848844b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 00:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793608296; x=1794213096;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hnuqUzzjgSEBIaiHp/opE7urPU3XKVrRGqxwgy1tl/U=;
 b=byztkGvhCso75s2IYRknXDgAGZuaOGRulumCf8wAc/c944Y6ZpcfEu9OSiA9ZO6eU7
 CjKhjRchmq4B9iucse4E62j0gv73M7T/1Bs6/IxshHsZJV7wsqKqhtO7o2V2hDOddu2T
 6tIcSJEB2tKaAtG4TdzwNutyo8wU3ZuipmUaIjkdyJTu7mFCSD/kbC058CRi04PP7A/d
 wzI94gBw+DjDgrIt9nPSb2McMYRW3tiT/LVv6u0CpKB+Z7phoAXnrJL6Ig/JMYgeKZdL
 Zx0mXvhCAaeaKO/JElnkT9HtRB+jQ1Pl2CFB7FdTqd8bueYx5JL+BM7pGiYU8gn7gLBS
 AAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793608296; x=1794213096;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hnuqUzzjgSEBIaiHp/opE7urPU3XKVrRGqxwgy1tl/U=;
 b=p1rTNXC2MP83itZX5lB4kCiZdXCxadN/+t+jqKUiHUtAJ+bnhiFfzDB0KzFPI4BSI6
 NXnjp0YMnsqhMuf5pZk4MXtRtpuYZiBOlI/bUorJdUJqYK0Vnv0AmXy5NKJLTUu+sfl5
 8IHsAHQHwxgl5NEUtWvDlvnTb3hNew3JFthaB7i4yB8OLm08jwsSqzy5qkwM2NDdOAmN
 g88tQdOAjcQY5z89RVHpU0hG4Zvd0JrCAJ+e9XnEnvXidkxU3bTZAdt49b4m6w6o0VgQ
 Bx90nJEh3TAXKZDFdQQB0v/reUUDDB9Dh6gmK9c5y1ynDYXq7XB5rwuNoSV6ECsb2tGK
 vFjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/LBk1VfmJOd93KZApaywKE0q1ug+pt1PRAQVspQC1QlksRpRohhirLbQG2qfLDiCG/pWo6vK97SA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/NqG96VIIMUJDURYpf7Gxsd3SOymVHvrMroUBYDTNPS6Ybjx75
 7Jyz0EWIdlagEpgCNXKcrrdt7jqZxzfGQ4IV+pc9A/rbTNmg+fniP1RFKkIxGz1O/xRNeJ9f/EW
 LSCi4LFh05sx6hGy7PWkr+uS1astkbFauhQiYwdM2pHG+EZ5FuSOjc0LJUE9yE9L/fROz7RM=
X-Gm-Gg: AYBFou0P/I6qWi0fzdKPdcokIVcuVPdbhbOq9l93Zn5yvKdqNLTYPkf1H7DVAEcsJAb
 7Hjrs6gQj+mhX6qJTdQ/bg+AMxsBOuJaeooLdTJLJCRt5K3cnMZPJI95M2L2ie8QJFZoXPZjsgk
 T4s/SVTWqJXuYIkUFIpuNOeBd/9jXjNVi6ON70zGMZIN0eZCKyx7pnNpA9UEm0QR8SIKftsYolP
 6ilyLM/BRyFokGH/O/fuQaeNHLXsfPjQ46lctkQD/qZO5PKRqHZnceeHSxQm+/crBBTZeej0O6i
 1kx9KkJXMc94/Rj0uXAwpdVazkoGLbRne21/o6muDBACN/M2RG8PUUyQjrQpR7HInpxyEKpwWF9
 YNcxHaMrHvodJbIZ8aEBiZGs5rutIlAPcS0YjywjVvE2HlM35uA787SyFmGR08lwhVt/UjOqvCd
 RABq/XPA==
X-Received: by 2002:a05:6a00:1d84:b0:880:7dad:3e5 with SMTP id
 d2e1a72fcca58-8a9c02be5e7mr7706594b3a.51.1793608295746; 
 Mon, 02 Nov 2026 00:31:35 -0800 (PST)
X-Received: by 2002:a05:6a00:1d84:b0:880:7dad:3e5 with SMTP id
 d2e1a72fcca58-8a9c02be5e7mr7706584b3a.51.1793608295268; 
 Mon, 02 Nov 2026 00:31:35 -0800 (PST)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8aad9d03be0sm1674680b3a.27.2026.11.02.00.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:31:34 -0800 (PST)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 14:01:04 +0530
Subject: [PATCH v7 3/3] dt-bindings: misc: qcom,fastrpc: deprecate
 qcom,nsessions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-dup-sessions-v7-3-03f06c014e78@oss.qualcomm.com>
References: <20261102-dup-sessions-v7-0-03f06c014e78@oss.qualcomm.com>
In-Reply-To: <20261102-dup-sessions-v7-0-03f06c014e78@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, devicetree@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793608273; l=1219;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=VMGzKTCz/azLzKyF9qh0sYFoOD2oiutFm8UHF1H6/Mk=;
 b=FTJZktJO19KaCxSo7At3dajbxHwj5iNmGTS7GVKlisRtVjNR01L481DINVU3y6D2KlWjucDwf
 sF+z9zbjT1jAXqJezx4r8sH7crhXH6OBi2c7G839kRPj5ew0dIvVtBO
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-ORIG-GUID: eeO39ON9rxoWFEod7clR1biSZ8OLBpmZ
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae84a68 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=e51zU0WOd6sbzzcJbsAA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: eeO39ON9rxoWFEod7clR1biSZ8OLBpmZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfX2VRhQf+eCVIW
 A3/iLtvcktS4E1xBnmNul7nV0Wza0zarLYusbRbBUz6MAjxTxBRYBlSyxDZ2BNzKG51zvr/sA0P
 W0fPadCi9aYfkDqkKfzQUOnmTm6VU9s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfXxGooesfDhacl
 Fm1z7HbTxykdHcvPgDAYunyD2m6rlElyn85meWsbFErDluXzt1NXRcQMambWVpfoxtYKw5Rv1KK
 HStP6SnL7kKeal8bRHn2EJu9s4LEoqCHVr5m0nLmnKxbAfjzZ4pRxNAi4NH8wCShFY/3Mld3nXA
 XKgohy4qjy2Fn3GWhpUyJoG8ih7tZN9K07zHz0ZQLl9nUpM2+RCy8F4XiTaRTq3T0OEMXbEw6EI
 qqNq5+8MJolD62V9z0bZsdKxamgeJeWOzwNz+FMeP3+maaq867EzfgPdqsJGKga5W4swFzLA8hK
 zCX5IWbwDi7uEBTA5Z8wOXNpfphAY/jcGb0e1l4sAiiV5vpoPwzzD0Ms4MW8mDzZkLfBqbbCtGp
 RKn8iWmYalkHLFRMuLM+jiBC91HS0LGLA3zlyzWELHjJns8jN6lihPdjZBhJmTXKZNRYBSE/cvb
 gpUyZBcgz8YaV/dIceA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020033
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

The qcom,nsessions property was used to duplicate FastRPC sessions
inline during context bank initialisation. Session duplication is now
handled at the driver level, making this DT property redundant. Mark
it deprecated.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 49d2a5e8ba39..e945c8ba75e3 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -101,8 +101,10 @@ patternProperties:
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

