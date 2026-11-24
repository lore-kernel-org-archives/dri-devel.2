Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6E0606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jepOCxGZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y10GiUR6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8521D10E699;
	Tue, 24 Nov 2026 20:35:29 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82DCE10E8C1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 20:35:18 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXoFm365917
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 20:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /lgmsLAWFTOpUTSUavZ1s40ItzJRXtSmrwzglhKM+H8=; b=jepOCxGZ/3mUXS89
 6SfFAI8VX2Qds7NbhfhyN5LRDjx2kRVYsFHIVo1lZwf/aGQc3aQyRGMJD2rDKA6d
 ASuW/1pI112r08jBl6CfmfViH96i1oN3EBGAHEDRaPUh3ROMSyfJ2olsvt2FwFpY
 9XKO/Sh2qNe18NdvXKdHsoSf+e0H1RZNXa4H2ztcrl6YrxOffFgsZpxEbcPfMcx6
 L3BOE4hvRCzJPrar0xjaNk3di9fK47Pw8lOFxkVgjLbkudDTCpGssDQM7g8mTBC/
 x4E5xu78jUbn9sb+wvrvxkgBezF+T0tMfIVtoOJMetdv2WYowbbdqvA3r8xOGDpd
 XCoHOw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rhbujd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 20:35:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-386a65fca25so3776888eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795552517; x=1796157317;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/lgmsLAWFTOpUTSUavZ1s40ItzJRXtSmrwzglhKM+H8=;
 b=Y10GiUR69I6bS/0OO1lG/yeS9mPlURBn7M75PQ3GhGLSUuIruS8zXc14ftgGrfIbnE
 h20UNjUh1WzWed5A4sGKaGLa0RY5EyL51wew7zdhpFyGrI4d9FEXFPq+E6YouJDcHxDT
 bdkGCke67WQREbFeQuf0UDFHznEkKEOdyrFAM8jsY8m7rzraxzmaMGa7xgJgdsblNRe7
 kT6xsqIXvQOLrlMegFWpnt2r4vQBCMGerY3d6bfN2H7cwCOF1N2dVgXLGjfceiEz4hE3
 V/VFvkyhxFcaL0HizCCWML+Q5yP2NJJV1YXBEVSDOQFNXJGfLhHGoaQRthgofBQ+Vt5f
 xl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795552517; x=1796157317;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/lgmsLAWFTOpUTSUavZ1s40ItzJRXtSmrwzglhKM+H8=;
 b=DUR/0NFJwBsBy4peJK0fCcNKogTpabhyOx4kchZZa383C+MdtBESBDsKc+3iLYU8ev
 A5SH5kxQpvYWhZ1jdXzJQ8/xXmVYVu5HUyuYO/iKDRS/UGfFdWDzkpzjX8/5QoBe/IEI
 nDY3+S4lRvF0HBd1k+d+L/DG3LK8JpylCOAGa0+dNFdv51qxy1P+rL/s4VsaHWHm1hfG
 EF+eGOJmBhKE2k625X5Jnr1Q6iAP0dFJrle9ZoV0uaf5ro3MuTgRsVN1Cg8CDNbK5hbD
 /u5TFX7EZnyEwhuwK7cQynKJfp8cW+SDtnK6ZTKlZgUsLLul9DRxKH9gNEXPNUTtlOIM
 ihdQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEFdmTGVntGj9vqwmCJUJFIPlwoDEihF5vfKFjOyjcAhYTzjBxSAXtHcrqxLBm0JyWJkXk1lc69NnE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z95SUQkmPU67xJgS9kdin7BLN8wRkW38VrK+KC+li4JqON6EeB4
 1C/XkAEcIeKLvRcBOYoihnSXhWZrsrirZRLV+gND7RpCBrI0N25sW0ZANlVd7fTgJtmDCn8a1bX
 43kPbE5Zg+y9Pw5CEoOykQ4eynZ4y8/xAgDx99Ax/spDJYgXJ7O8MhMrM9zxiZ2HreaVXJ3A=
X-Gm-Gg: AZFdTZcaXsB+x1oOBnuigwCOAIwpNAFI8feaXdCDIkzB+Iv27aEw+S9l86RmymBS/LZ
 KLqFQWrxX4iDAwxoBBoB4VPpCHZSXvn7LQODRoDWxQfoKc/IqTW/9U+ci+g3JIr9cnQFz+LAuNU
 z7dFEw24dM6pNWyt9bQdPYRNuPRcDnvhox/Ck9oBmn5I971clMpUtSZPkAHqZ1mmZ2+vC4Jp8/K
 iIp6MezxxK9S22IoRZgTXur14hZ9UnzmIi4A0MA1mObtWlaITyGEQgEptsdm6fm/hi9+5He0Wpl
 TeiY09evmu8mbfM9Ak3Z/ksWinjS9/VGPo/XhwzVqnPPzZWOd6mR7BRPIUsJA7Zv40Im6HJNnVF
 lXmNTmm0uzz91ErJyUuMnqlnh1XrhpYXdJy0UzBlI5pqfbx6BW/m4iG4PI/1vK9Hpmb95WF/z8+
 O3hLrK4LrpRqccvA/xUAWSLsuFMI1Upq8=
X-Received: by 2002:a05:7301:6083:b0:386:a01f:a36b with SMTP id
 5a478bee46e88-386a01fa8d8mr17003149eec.35.1795552517007; 
 Tue, 24 Nov 2026 12:35:17 -0800 (PST)
X-Received: by 2002:a05:7301:6083:b0:386:a01f:a36b with SMTP id
 5a478bee46e88-386a01fa8d8mr17003123eec.35.1795552516435; 
 Tue, 24 Nov 2026 12:35:16 -0800 (PST)
Received: from [10.226.48.50] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385672ce402sm44409448eec.16.2026.11.24.12.35.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 12:35:16 -0800 (PST)
Message-ID: <fdbe8a18-fd34-4419-ad9c-133b38f818f4@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 13:35:14 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ras: Do not fail an error-counter dump on a skipped
 last ID
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 "Michael J. Ruhl" <michael.j.ruhl@intel.com>
References: <20261124202102.3578912-2-rodrigo.vivi@intel.com>
Content-Language: en-US
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
In-Reply-To: <20261124202102.3578912-2-rodrigo.vivi@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BKkmP1QG c=1 sm=1 tr=0 ts=6b05f505 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=VE9ESCdJRH24Gw-HOaMA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA4MCBTYWx0ZWRfXz3PNtHZ0w0DB
 M+PduqGngFUlgDpVslFXKE9zltd4cCfr2894M7j42hvbhypVjFulWgLljnImxwvtiEiU06/PHnm
 Ag7h/RfSQ7v9zg49IWyESWtIqQO/KGY=
X-Proofpoint-GUID: rgJUxpYEkX6jgYUvnhECuS4IAYCiHssb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA4MCBTYWx0ZWRfX9S2CN/SLtMCb
 JPNYPlbnb8E0mlnYAhKK07+X9bHA9GbrtvMz2jTcnA06qg/Pc3+KrmK4dh7up1wGIgw7CgbCgsG
 lWKZKCC0NQ9J/xevRycRfcL4n3bBu/DS8SOYFeaxJqt94QuhZ9J1WVy195t/qXsbwtQpLLHDOCW
 Ao8hSfV787uX6mIAGzv4mfbDsuoeRHO54LzrQgIYVE6kkuGSBZqDkrvpqH6/IOqhscHyXDVZtBI
 yAoPvPdT3gv5SQ06POIBWbyh53oPB2eSB04/TC41DyF0rdw4zUZYJBXZq/M2XFiRtaPTg2Ey7g+
 0SeZgEb4GJD76OWh4IXCGrfdllxQgA+8zFmd/X+85QobEZ8bLb28tJ9tzjvXvosbgpTR1fOBcCb
 3Nx7o1cEPksYOblKDq/ud8fmhkn9Vv4WeaMr3Ddi9QbZZR0tNahs14b2mRW/RWRimcaIEX/7Egr
 l4WcDhqq0iO4Ca+E1tQ==
X-Proofpoint-ORIG-GUID: rgJUxpYEkX6jgYUvnhECuS4IAYCiHssb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240080
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/24/2026 1:21 PM, Rodrigo Vivi wrote:
> drm_ras_nl_get_error_counter_dumpit() skips the IDs the driver reports
> as -ENOENT, but keeps that value in ret. If the last ID of the range is
> skipped, a complete dump then fails with -ENOENT.
> 
> Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> ---
>   drivers/gpu/drm/drm_ras.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index bc30bf0745e5..82fcc766b84b 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -616,8 +616,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>   		 * For non-contiguous range, driver return -ENOENT as indication
>   		 * to skip this ID when listing all errors.
>   		 */
> -		if (ret == -ENOENT)
> +		if (ret == -ENOENT) {
> +			ret = 0;
>   			continue;
> +		}
>   		if (ret)
>   			break;
>   

Reviewed-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
