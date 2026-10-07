Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EB4CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4771310F4A9;
	Wed,  7 Oct 2026 08:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nj3iRZ0o";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G4xO6/H4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C950110F4A0
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 08:28:00 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jh5f1873625
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 08:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Q8pejVtvwEZY0CJvyioOv3uZ
 UkPCWhEsgph7Y3WL6kc=; b=Nj3iRZ0oHMRNpu8bfSlnIuvRndjXLi6nECGFp2yT
 ZNn4syEZO05KUq/tq0R1NUNJ/zSZ6XCdzmbUy9KIqGCh7tqzlK2ZuHTAx6w9nCS0
 kXblAZqmvVJBxnRCXy6My+ORzRwPfFy1JfrMKipdIupgN9umngAK24gKe9OPlbR7
 cUMRA99Y5LLJF4Nr6jZCtdfI9uvYIFBuGTrY+CmmpoDymZXO2tmm9ofxEkENmjUl
 o1zhg3T6+gmyeDfqFUINIzP6Tmhu5mukagdlwWeqAvwUIkmNlHFPmNOgWYp8YHOn
 gT4T5q4XsoLMWhMJTec6eZjkVJUzIpCOLQBwQk06q9jrLA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fw8rhy9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 08:28:00 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-14373747468so4335652c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 01:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791361679; x=1791966479;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q8pejVtvwEZY0CJvyioOv3uZUkPCWhEsgph7Y3WL6kc=;
 b=G4xO6/H4NrWDydLuQl9zmmZ3HU0wFvf70pjeiE4/3ZdKQQXUdyC6D/ev0+Ucv3emQD
 QUf/6GRLyGEnOvZv/GWnlBTG5tCLoswUSufpT3wQRPJfnptR3wzfJqQNrX4f4mUxVBB2
 5QM36xZXmT3WCbg3ioDe5SY/w75AY7P9JbN2dP+ED0gdhB2Whwme8Le+2lPjylaqzvdc
 WiyCu8Rhyr3phBMf4Jk8EeM+wbYi/aFd7l8z/DvdOWPVSRkmO03wBQ3e7PnJNLUthPeW
 MjKo+rmST2QtctqdBInLYATSi3gUqIUAVYK0mCpOpBxkPi+zRx/jxKgHjr4P7GrR8Xfg
 X5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791361679; x=1791966479;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q8pejVtvwEZY0CJvyioOv3uZUkPCWhEsgph7Y3WL6kc=;
 b=Rwp8CfcL2/yxQXGp82Tvn6Brl2Gv091PE/axYXrAUpXYKPvUcOLbDeS4O8j/48REW2
 PdNrn4mRIV5VTliccKTEX1jeaoUXsXICEUZJtwXeKLzNmmN/CCERPabAlorNSs7voXQ1
 s70FDvo9zA8LzSvvXAhyd1R8UdmtC4QEgC0eSApkRKhyOip3zJ09wU0Irose3l0QAMDH
 SnkQT2cWn34U0or1V41RfR9ZursbbQMgh0mDEXlbeq4OtHs7wRRNF1e6w7ONhKwGApXm
 rzwwxgMLMhIihtJACRkclMgpvR+HOkRzupmbffhGXrYkRLsbj/Fi0NheBWGbPnZ5OXC+
 9FIA==
X-Forwarded-Encrypted: i=1;
 AKwUvByrg20CS5pqUpHeB8SHA00guPLxiNGqv8TYeToiFyrLqLngBKgc+vtwx+LuHinUS8mOhClKLwRqzXI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mthXXuy3DzorfJ/OnFjSs/PwYhKoIyjBc9Lkxk5t0dooKgLEp2
 cgRX5x3iX+n2x2qCVAjYAnbeEvwl99lpeJSROTuM+MXPJL2kBiGccJBvwhHVkjivsfjp7BLON5R
 1ssr/l8Fyn8fMG5EOjQ2MIum2YqHdoDL0umWTilkYeBLaPQ6CABMSl001bGx8MeJkKLo93DU=
X-Gm-Gg: AYBFou26ovU2qdfU1uTbTARFK/bQKi85hFfFMzQYHHeYpdUFLIvFP0UMDne0TDVRpg6
 rcR4iwuQGyBkmRahV4Z6+KDraTtA3wlQJKXbF1XIHGWwIUdwLE7s8KEZG1/GQBume6VsqCUZElH
 3Pb2PmQshLI7KL9w1Lyhi4UC9uYIV4o5wFl2n9J7J0TbsCqP4rbfkLOEtCVFc+F0Eu3OvrhpX3b
 RD1k43nfYwNFSi/LpDiqwC3JvhqP7GUMBdLUe6KGwRCf3Bfulh7V+VuFfpzcBWh2K+fyO45pdQ4
 aU34wIlFRScodE+F6tJVH8W4GoxDEAu3Tjot3JuPLJ1tkOVUNJapmFMi6L7AboIK8UakBqhN4zT
 CvAl+7Wk4OInLFRhSUOB+YkfJoQ==
X-Received: by 2002:a05:7022:3f0d:b0:143:3c9f:109e with SMTP id
 a92af1059eb24-16208be0009mr1524600c88.41.1791361679069; 
 Wed, 07 Oct 2026 01:27:59 -0700 (PDT)
X-Received: by 2002:a05:7022:3f0d:b0:143:3c9f:109e with SMTP id
 a92af1059eb24-16208be0009mr1524566c88.41.1791361678408; 
 Wed, 07 Oct 2026 01:27:58 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16167ef2e54sm4519079c88.10.2026.10.07.01.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 01:27:58 -0700 (PDT)
Date: Wed, 7 Oct 2026 13:57:48 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Mahima Bhattaram <mbhattar@qti.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: glymur: Fix fastrpc compute-cb
 reg values for cdsp
Message-ID: <20261007082748.bcdhzhqsrl25nimu@hu-mojha-hyd.qualcomm.com>
References: <20261006-glymur-dtfix-v3-0-44e2bc5370c2@oss.qualcomm.com>
 <20261006-glymur-dtfix-v3-2-44e2bc5370c2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-glymur-dtfix-v3-2-44e2bc5370c2@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzMyBTYWx0ZWRfXwsTOPtDgDrh7
 QX3LvZXPcYxg1ObOvY7c4tdEwv0lNNAGhNuGE4vQxttTvZjwb06bH3CAmZ3Hj1adAbEEcc3Xwuz
 SRab7OBs2pE0i4dcjtVINPig2/YX7D0=
X-Proofpoint-ORIG-GUID: s7rt5DmBkg0u3UIndvz12vGvt6qdkSIa
X-Proofpoint-GUID: s7rt5DmBkg0u3UIndvz12vGvt6qdkSIa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzMyBTYWx0ZWRfX6tWG/++FBT1P
 XSIjsCKw4uW28CpPxwzLOuUuGqrl2PFzeSqRxlZdPnbcfUvX1o98ZCGqFoLGfg4njF8bHe/eO2K
 jxMHjLSiqstqqjU/0s97g26CfTinNT9jGX7NZCW+96EyHQxOsJwknZfkpw24Ed80/eVRkasfzbX
 kTzpY8OeIL9iQ+d9qBRbXIW2aCx2WicalIEt8weSOZW8NSZ4F1/0ffgK2BCOLYv7ZrRh6wFRzln
 eMvbNAUQ6xQgVIE7FlvYsWMFwbd8PC+ep1nxXtMPFlf2sIqLtJeGwe66n7whvCGbcZowr+KHj8/
 7EcIhvT6ZmnslaahhrCh6gS/YqdPdajQF8tp7+3JINKM+4+XT2hd2uWJq8QI0W4d8rFB/5QzgH3
 I+Cdi6NeXFI7C/EZH7E8IRU60C6xWDHzLBm2ragMConXrITLF+ZjLiYZKQQE9v49yr12jHWNH0E
 Xi+a+ZRvdvTg+dIYF6w==
X-Authority-Analysis: v=2.4 cv=Af0kjHXG c=1 sm=1 tr=0 ts=6ac60290 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=v2SviNC_9pf3EYpT8dcA:9 a=CjuIK1q_8ugA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070033
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

On Tue, Oct 06, 2026 at 03:56:07PM +0530, Ekansh Gupta wrote:
> The reg value of a compute-cb node must match the SID (the lower
> nibble of its IOMMU stream ID) it is associated with. In the cdsp
> fastrpc node, compute-cb@10, compute-cb@11 and compute-cb@12 were
> mistakenly given reg values of 10, 11 and 12 instead of 12, 13 and
> 14, which don't match their SIDs and leads to SMMU translation errors.
> Fix the reg values, and rename the nodes accordingly.
> 
> Fixes: cd1d174c75f7 ("arm64: dts: qcom: glymur: Add ADSP and CDSP for Glymur SoC")
> Co-developed-by: Mahima Bhattaram <mbhattar@qti.qualcomm.com>
> Signed-off-by: Mahima Bhattaram <mbhattar@qti.qualcomm.com>
> Reviewed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

If it is possible to cover all the SoCs like Hawi wherever this issue is
there ?

-- 
-Mukesh Ojha
