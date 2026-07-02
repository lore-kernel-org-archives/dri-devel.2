Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0665C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2213410F337;
	Thu,  2 Jul 2026 12:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I4DFLHXV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dGttklQp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFAE810F338
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 12:23:17 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662ATLT13591664
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 12:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H3yAMBOi6v9eV+nAc7eVAGvVNWiyX5n7k7tofn0XxxI=; b=I4DFLHXVXlt0GoIW
 dfrRzLqyw6s67krAgqYSt6uR+IDOUqir3lJqb8cjfvc+WfrR06mPcdrVYhASsGpX
 LDWlAIsxrv6nUMWL7UFHqiKKddhfMNNcBJBnT2vbhL1lO1bmKk4ToK3uezaJLgfb
 vL/DWrGi/mTNnY+cPoI8dtbXSokmFzVNVuswHkJ25BRq2wpCA7pwiPvVjqAzsNuX
 FMcUjrXlY84iazu1GnGFSWFmCuDzcq4Psx1TfYpo+zOw7aAYkS173PQq47+nZpsb
 A+bVUvqbOno3MHvb6oI6bCLcJHH5JYvBxquO0tf15x74MISA0/9SUv10GZob+np+
 n23xWQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n9nv7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 12:23:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c07313be5so4287161cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 05:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782994996; x=1783599796;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H3yAMBOi6v9eV+nAc7eVAGvVNWiyX5n7k7tofn0XxxI=;
 b=dGttklQpKppnJq7ZN8rqz/i5lnKThaHZbRXcPnobjrUYwT7WvzA2HbbIncZ7NHJlLE
 d61otpwFHRVCdqrcLjZWlW3rZ78Pettxh4VztQ01d1hA7snq6u+i7ScWCt+/8uNdP6GU
 GJ/9yRSlnzMFG3lFtSnf5EcIxi/eRuAx9bcH2VGlV7h5We40LuvXc7Q7EYpUvJaV//ZR
 vg2173lw6dwPkA/l6Z2Jna/hdu+U1WEK74+6vwtsmxh57rcBuhbmMK2wNvNTRoZczeA+
 j6v1SUZmGnvpr7y2kLuHE0wMMZzhAh6e18o3XCnmdVi1gxgZObIAh2MsiCQhAr2whiSW
 mrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782994996; x=1783599796;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H3yAMBOi6v9eV+nAc7eVAGvVNWiyX5n7k7tofn0XxxI=;
 b=oYEMPcFhGCVmJ/PgZbiQV62T3ge2j99w67kQZdF1acEtuYva5mjX9nWz40MTFFfc9K
 jnDRyGVhkAjuPPYNX6oO95//0BZEh5HSaFzkFX2POnhz9QVawi1WZa7akvl4C0Bt+nmk
 Z3U1zTykh532ZPgTsOQTtyav3auFZ8RzStKRXJUahDroDVRhrdTFw3KMDCLuSv+ic2HP
 pt3yqYIB/FA2w3/KzTcUttLKUAY50W2bExbz1Gi/Gq7Z2D2C4cCyXjXF6tSgXO+W4Ggk
 VdM6kcVm5F5InNhAsgAuyf3dOCNVLakWb/3vkz0TtmL3E0ztQoLxbp5e0nIv0al/t0L1
 8O+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Hg9R6QlxZpjOvqbOWTCPdK+mJrxX/bUM0NOTI0/5gu8Wm75nQUmHBsQ9bv4qnAwh2yGWyrKAeOI0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCbdwcBM3hzV4OW9qCgbNk/zuX/4YztkGBqJZATlFJ7qOA0zLU
 vYEZNxMST8A5ewJ0TIq3gXxb2C6rlI/6ebWXGz/t8RhAJylXSZrHzwOQSYs5AO1Nuq4CstJUYLn
 P4usSpOacdeuFy4Wf5E+CTL1Ruvg2Hrlf39nUnBC1Obv4hdqeXow6BnHzAGdjNTjDNm0me2w=
X-Gm-Gg: AfdE7cnIwJ17Yt/wiOpt/l7+qU6BVzXaCT8SdCmHMwRRudjJq/CgWK0dnA415Wt+Kel
 1tOhLtJ+CwkKD4NkSRoHsBjM7cp9iSapwt3VY5y+Jg9ip91vLBsNofoGqoVIvd30v1D0T/Nm5qz
 ekvkJ20TBGMW9DeWSIjyTXPgVYPddCdjwtRaEIc6t5PG+dhXGmRK3phMrmLdzori3MGvNlbqKgT
 GEdmi5T1vXKu4Cwu8pxuEnfz05FbBL7WJI3yl7r6hyAo2OKpjij0Djgt/bSdZnmnOxbR3VwSOqA
 C63tThB3QjdYBg/3PYhLRAtzVXqaRqRM1pefIEOcI0pXeUbbhyC8iWYpvSo1O7JfJvmEVGpKMRA
 ZD3rqyr085F160P72RRp7MFG/t78ZP6Vl7Ws=
X-Received: by 2002:a05:622a:14d1:b0:50b:3489:5495 with SMTP id
 d75a77b69052e-51c26b3920dmr46801391cf.8.1782994996322; 
 Thu, 02 Jul 2026 05:23:16 -0700 (PDT)
X-Received: by 2002:a05:622a:14d1:b0:50b:3489:5495 with SMTP id
 d75a77b69052e-51c26b3920dmr46800541cf.8.1782994995674; 
 Thu, 02 Jul 2026 05:23:15 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b60545dcsm122833966b.3.2026.07.02.05.23.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 05:23:14 -0700 (PDT)
Message-ID: <a2e5d6bf-e2d7-4252-8e91-1355c481d35a@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 14:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/14] media: qcom: Pass proper PAS ID to
 set_remote_state API
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
 konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
 mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
 mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-11-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260702115835.167602-11-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMCBTYWx0ZWRfXxrNonbGXfVkB
 eq5N6+4V5fiU0o/O4p5LbztxcxMClmo4kNRIBNf5LsUQl7mWt2FX+/Zn/SQyJlIlNLw1uKDuLic
 1Jt/NAjI24gvE28F6apul77MxGkT3kkXfRssHBQF53qfqmEnfgrpQy65CLZRjc6p3s/e0CIleor
 7Hg0awW+o2Crl3KMi1xlMtMGbbbRRIKrlJPApith20HrbTqwYB1a0ja9k8dlBrm53S5eGqyUHb4
 NxfqzLrr/8oCgnCB471dSkKfWz5ZdQAedCSg/OpvqYKHiWyaqHw4oaUqzcjDgOryhk237ksfRpz
 jdxbx3Ce2trGrO8yqUWlBAK5eczHZENEYWZEYM4B6QGlkErRq4x8dIjpvYUJcYTW+wSo4BKAHCn
 1eG/UVIET/+ePi1NobzcEBx5Dsco/H5v8+VsRmtNUXF4kW2Lhbgbh/qwPrrIDlw+ogGkH+5azb2
 THuY9bpVerTxQS5s1gg==
X-Proofpoint-ORIG-GUID: ogx9DnraZ9FEsO9MW-_lASSjezZP4f5A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMCBTYWx0ZWRfX82Qg5QNq+nbC
 fWgQ8rlECKljLHzl5+0kB6ECxsPIKchoKNLY6emIRRKDlVmGbvTuQ8UzIMRkD5B4eTE4LX2Dysd
 uJCMgACnqub0Wku71lGc8PjuoJbyDLQ=
X-Proofpoint-GUID: ogx9DnraZ9FEsO9MW-_lASSjezZP4f5A
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a465835 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=d_vIauj3UwZ4nLxAXMoA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020130
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

On 7/2/26 1:58 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> As per testing the SCM backend just ignores it while OP-TEE makes
> use of it to for proper book keeping purpose.

It's apparently not ignored, but 0 is assumed to mean video for
historical reasons

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
