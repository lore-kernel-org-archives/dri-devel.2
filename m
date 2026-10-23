Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C52606A329
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jp2rz4zD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z+1OTqUY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1092E10E06A;
	Fri, 23 Oct 2026 09:03:57 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98AC510E06A
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:45 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FLIH1552399
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NpvUnsLAKwd
 /VAqUA+EeIsjP7hKPCef0EJB8HBsJ+lw=; b=jp2rz4zD7ONXgwQ4HAdOHz0I/UU
 XP7XVbP1vv1aZ/jk9kPG2LRl2DOtEHvLzxCS1U0Q6CAxyZ2dXt5vZ2eIzP9u4Igp
 fd3rPPbUmmeGJSUBSGomYy60LMt4x92hwgklMnojYjrHHpVkqZ8JHEyls3SZ0DMH
 FO5p160zcqI057JZbOpt3DtJ/u5e+uDl4acJjieg/4h4XNfeGQb2wSMxCXkDhnUH
 b2Ru27Hy3Zmx+kWZbWRTti5Of8UZzxtNykBW2HgBgzlBjFyi5xNGZGti3YLE692W
 WMkwrqe/PMN7d1WKcen3a85hUI7CPlYxoot3Iu1I3q2I7DLIes4EV3Ho7sA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmttv14-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:03:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1cdfb337eso506900a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792746224; x=1793351024;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NpvUnsLAKwd/VAqUA+EeIsjP7hKPCef0EJB8HBsJ+lw=;
 b=Z+1OTqUYMsAxtY84tPEKgvJSTTxIlYc+gSSmgygInC4IuHdmHHM7s06EJxovAlXzWd
 OrAxC627bUdt58f2jUfFmeCDf2CJylU8/1fqCAj15kvuiFIWsFNKvLjd5N/TJfsGRx8u
 yiOfsxYEQEL7PAbOArg/4RTDTLQjXojc45OxoePTiC4pJt0A3JCAd//Gqmtca16JdVxs
 AT7UhsbHrb8+cp7rl/7qmVHjqjcuNGqkIDCOOlZWCmNYPK3YN25rjdtCIMfZo8hjiMcX
 gNMMxxHFMjKEmFjBaH1txWuj28GeXXkI72wRaY4hgW3EGMS/BAQAJWkmh7PEpeLHPma9
 CKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792746224; x=1793351024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NpvUnsLAKwd/VAqUA+EeIsjP7hKPCef0EJB8HBsJ+lw=;
 b=ipJES+FF8VD0KAXPsSYRkjjEiI8OVQ3mds9HUe1/z2ZSWySzvAynqqmFanA7xJHycA
 330hvHxcMxWvypF+7tYtvdPW6OuQQSneh5yQM3mJU0IFoBXtC/fXVgTqXZoHbSdi+N5G
 jgBMlJ3sSDb1mSbI3eHv6WBnkIV2xiRC+538rVly5vc/WoYtFpz6/aSBjX0D6orCoY4B
 GgKYRppiG9PuerRXgeImtsDCiQQI9klCH1xMPL4OHLpVQrL5qrMzVHGvgQeTtOMn7I+Z
 WdESQRrakdbiUvCLeDYNB2ke5v+cTC+8ewRd92zARUkH5nVXDPszztQEMcjLlt0524iJ
 9egg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDi2EKLkEeebKCaAlmK49VDV3P1TDuZbUGA6nRSINi8yXnEkauASZcN1hR9ag2Gz3sU8UFsjtIKow=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKuLu08JZ+hZzzhq7fXZPy5pY3x2kVyMU8MAOYN13IphWXDZzaD
 I04O1YMb5s9pMp7EZZK6hG+GUHnOuV78AO9lbkg7jARkrOnIARXK9v/GvFVaiM8zNw/eZm4Eqra
 haeYiv0NeBV/DyftaDO1dbUc8AaKlmPHTY4AX9JaJsnVgNzBw+qMng+csL+CDIorILR5O0w4=
X-Gm-Gg: AYBFou2nSGjHHokCNHlhYcM9Ou3YPMMmWd68SYxpgpju+mi6CVjJQ0YekK4slET8uo/
 iHAisktZR3ZoR/c83xMCJu5KJtzBqujqAPvrV7b8BpcMiF90e9IBqz5epIngLQCSGaxOoEt9DTP
 cxaOwkBHQKq7uIYzRObEQqwPNUFzb4E+0CjNkBRiZcPEJvob9o1pcRI4ObVifpGb6SrrnsRTNep
 2X9O2PHiBFdzgTYRM+nSNRnRlxDzIHKcjnjGSYIIRhT5rUhC20GVfhdDlBgT4UMuIiC+emQkeKr
 jSO8O/khT8CnJdfjOWe1vM/lhMMLfAEgm6OvBW4PwiusipgmHCY4RrkhBvWwgOMMd81QQNgHFNJ
 AE7mzDq07PM3gOLUPm5XklGprc7xswGHSeQ==
X-Received: by 2002:a05:6a21:4989:b0:3e0:dc12:8908 with SMTP id
 adf61e73a8af0-3e376748cd0mr1004542637.81.1792746224494; 
 Fri, 23 Oct 2026 02:03:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:4989:b0:3e0:dc12:8908 with SMTP id
 adf61e73a8af0-3e376748cd0mr1004523637.81.1792746223965; 
 Fri, 23 Oct 2026 02:03:43 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ba69ca4dsm586273a12.0.2026.10.23.02.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 02:03:43 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
 arnd@arndb.de, stable@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: dts: qcom: sdm630: Remove FastRPC compute CB9
 entry
Date: Fri, 23 Oct 2026 14:33:07 +0530
Message-Id: <20261023090308.2898683-6-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb22f1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=E36itTYgs6eEPh_MiKgA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: YjzZN_xViXeGU-ZfL_mRLXLyBAZOs0lG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfXyZwchKIDxWI8
 5XDinY+Dj6wLFpFK15SyTOO2Dcfa3tqi/m2UCXKiy2kBROxE3kRstCcwY1sRaKotUnQIpj8JP+F
 EuQdSGi0kB2WcIrN1P+PVPfRT4qldkOOGIml9BvBxw0glm8OW0f+AzkCHnCX18xlYUxN0zD6IFw
 8VUcMhEUeU23y9y2Kk7S8f/5RtlgQN6N2GL8D6xintq/bNgO6wY0jJ4msOKXBzLwc0qeofq28fe
 71T0AivIPsC70M62uLCPzbDLw/hNsH9Md6U3q5ZydK8mQ5tyG1qw5idcH8tzAEdCz1bio7lJTAU
 BHb4Gq1mSLsqm6MZLCzasAt4z6mM+Iah1V04GZ0i2eYHPoKcGZWEyDDZJabJ7VQVSaUBLXedkiY
 OgTk4fhsFosRQNqq+9ydEltTIS1MUg1+FpkiKgJ46q/wmH5dZX1f60WPym3TEqQtfWH5mNFCFsp
 EI4eJ880x+/Xa3W7QkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX2YvHgd3RHYG6
 H1AH5AYeOmL2up0N0a4zsmWmEHcc69xNVnm7Dsu4hb/B6bgZxN9Eh93ylZbdkY1blfJ+yDhkOmW
 npCYkHR9bVsRW522S2dO0RLA+xkZwoc=
X-Proofpoint-ORIG-GUID: YjzZN_xViXeGU-ZfL_mRLXLyBAZOs0lG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230035
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

Remove the compute-cb@9 nodes from sdm630 device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: e8e1fb5c703f ("arm64: dts: qcom: sdm630: set adsp compute-cbs' regs properly")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index a41ba0da380b..721885455639 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -2483,11 +2483,6 @@ compute-cb@8 {
 						iommus = <&lpass_smmu 8>;
 					};
 
-					compute-cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&lpass_smmu 9>;
-					};
 				};
 			};
 		};
-- 
2.34.1

