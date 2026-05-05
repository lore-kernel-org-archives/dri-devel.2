Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B108FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 14:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72BE610EAE6;
	Tue,  5 May 2026 14:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VElEevCX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S5C4RL/B";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C8BF10EAE6
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 14:27:14 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645Do6YZ3475910
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 14:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pySiRqtx4zsZPi7B448XCfGRj+cLU/DeaDKDCajYXho=; b=VElEevCXAp/4eN7D
 j1foutEYx3Vr8neaXKIuICKqkE91uo573myvYqdDi3F5IXBbLooVoYNRod044YSw
 lR5mKzu4rIzdWRx2d/JbjvPxo63qQzGipzt1YBAOZDb5CwgrEeUBk9SQBK7yl7Op
 RnlGVj6RDVf2ezLny5rvOLp51ciXeHa568S8WVA1PeQpTaKKwley3XRb2f4jQskS
 Hmhv3KZWzdQeiQy5aE63//4swak+N6C1OmAAB5qmJA/QhPhJGZUGiWR296GpH8oC
 jGb+vyiCVHK5mJH+jvYSckZJgpYqawQ3A0oPr2XYkR5r+kxenrr5UZyU9vAXrI3h
 JzsaVQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyhsgr4te-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 14:27:13 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b81ff82e3cso2908948eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777991233; x=1778596033;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pySiRqtx4zsZPi7B448XCfGRj+cLU/DeaDKDCajYXho=;
 b=S5C4RL/BZFiVXAJnwOCLD68agJj3FSs0b8QzUK8j161BdtHGAPbZRmOPP5TuwVD7Wx
 X8pTbjSnAV3weBk/rx1mMM+ZvXIVPpdQ5FE4ozh+L8f3lH6LrtThNnjMXh0G06Uo/ely
 21BPq3Vc4AzbKOX6fLCbxUnqTF1I2gqhu222usujOSa1LHUYZo/1vhFDOt+XHsJZlki3
 bYMFGlGB8I1Jd+pEOX6MQGtoGjvTzyqZaeQ/cPvi5LgEWlo69WhghAJrRwtsgcn3/HoI
 AHY3jk++gazH12F8kWtYqSLuAiSZEgIr7/gBoINxCstuJt1gE93JF4jvDtg8tnxje6hT
 QSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777991233; x=1778596033;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pySiRqtx4zsZPi7B448XCfGRj+cLU/DeaDKDCajYXho=;
 b=KaRhLEGiURmn06GwtmOn9TSGmyCXUJ6NQtmoMbW0Re1MAra3WSWz1JI0x7b4LUkLMO
 rCwDn5YTGETZvFDW9wOEa+8D2HdwaZK0yZWvPgkdBVubopwhh6UBIxa6OLA785ELdDuN
 mx1V+qU7VipZr7sv/I/h3FMFZokp22z/kAan3sC5VfQre5uQiLz8v1MFnfzrDYIlFCHR
 qY6xPYhNB+BuWv4JZ87jcclA+Qy7AzMntMzitEr1rH1xj53beayi6Sz5amoqcx0VNEge
 JXRaUdWvJsNl4Hqo8dRe2utggJWjPkBXZLLvA4MNWTxM0fPQcXkE3PA/1wYNItAZtsAv
 4cBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VYYx5s5YJD6+9HJYF0rNED0sf7SFT82kIVRThL1yW8dhjARNtyIWvgpiBUpNjtnAtgvKhga0dNkA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAHHf8Vz38+3jx3uazEnGNoOgl0R0Sx7jbuB1Yjbhlc6ulxGps
 5bctDLNyRetcpKxJh92fK4tJLSlJ+GTosUBW2gKpVaogkRijkxBnRJdeEUTNAAYHkR7G6SmKPgt
 agchLZosjirZzmOhiEFOCOsxEk0xL5yPaMDcO0FXQMcYpnUb7gq7chB9Q/kbep02slSP+gbU=
X-Gm-Gg: AeBDievfqYzqCt3HdLOqZ9XA+8jy0pzKzOBMvh9hmU1ObTAyyeJJhTt0a+oMpY6LHLG
 1m6/gS3PgrhwZvBhM7e/2CzmocVjZZfCVJwrRUBPg3il6xI+GcmHahOusguL+00jsLatE5Cj5pS
 peFevI+HGL4XiyI/4RdyT1vPd8H4RVr5LrHxCgAUJoAfEuWN63iVoJxN6LE1IlROPH6D7yMYimz
 pwL7UfUxnQRP7dr8Pg+DrF7HN4Vx9zzsGSR7MWpoANhvaWouiNgVMzx8SpzzY1mqU0xmUjrKtm3
 /WLAsFtaRlG93nxivql9+VbKC2zrlRJL10S+3u1kfOIdfUbCmgn2wYCq5XWoJMF0eApsUBOIXki
 0UJybXrSYHjTKzEal+vNKKZRl9K8Pn+ZGqcbP1eSxRksVOBhqoqfG4N0A02ogr3MfhGf9Kr+TVs
 0vjbSWXUPU2KaBR3g1
X-Received: by 2002:a05:701b:2507:b0:12d:de3e:86b2 with SMTP id
 a92af1059eb24-130a9ffb6e3mr1020237c88.21.1777991233091; 
 Tue, 05 May 2026 07:27:13 -0700 (PDT)
X-Received: by 2002:a05:701b:2507:b0:12d:de3e:86b2 with SMTP id
 a92af1059eb24-130a9ffb6e3mr1020185c88.21.1777991232530; 
 Tue, 05 May 2026 07:27:12 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12df84252c0sm23637548c88.10.2026.05.05.07.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 07:27:11 -0700 (PDT)
Message-ID: <3bfdc11c-115f-45ab-b0ab-75ad88dc6f31@oss.qualcomm.com>
Date: Tue, 5 May 2026 07:27:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/16] wifi: ath12k: Switch to generic PAS TZ APIs
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
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260504130603.1474043-1-sumit.garg@kernel.org>
 <20260504130603.1474043-15-sumit.garg@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260504130603.1474043-15-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iv7dThtp-2uOBBG9MtvV8YY1e17vsVZk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDEzOCBTYWx0ZWRfXxhu8FGQbl1ik
 od1Z7rerlJyRUBVsN/zU8h6hgY71RyH+uW/SUuYLPt9yAubtBOhyO8A77QnEOEnirpM5hPauv/D
 NahDk6gL6GXMjULzQN+0Bu1IvrIARIG2rahhJNTB9C+pQOdjhdL6x6lgDKJ7mdlz3cE9AKGhMdq
 cpJ6f2BwlSk2vQaKlT592Z/3DybyKDM07ErufBel4op7ucY10OC2mbu2XFkWYPO3D1buN+MyYky
 itr1g7MFZytikEEM54klhFppYU861G1/OBd6owpfwG/wj+rmL0/tm1/IE4zxj9xpI5gOfazr0tq
 j/ocMWcUpVTiCQ9p3ciwjZ+ix9PnzFR0/3RvobeO7EwaRIjtpja0Mzicsj7NgDiwQdzCQSBoK8D
 5j3/sNTFbt7ZRsEEOGxJYswcPReMArgHVopNN1o0i5niVya9LeVua4d9yDj8Vy3dj5KXOBuCYDk
 uarTMGPkNSTMR4E4LPQ==
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=69f9fe41 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=_vM1m9lfSBLZ1nnPSXUA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: iv7dThtp-2uOBBG9MtvV8YY1e17vsVZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1011 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050138
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

On 5/4/2026 6:06 AM, Sumit Garg wrote:
> @@ -485,9 +485,9 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
>  		pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
>  			 ATH12K_AHB_UPD_SWID;
>  		/* Release the firmware */
> -		ret = qcom_scm_pas_shutdown(pasid);
> +		ret = qcom_pas_shutdown(pasid);
>  		if (ret)
> -			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
> +			ath12k_err(ab, "pas shutdown failed for userPD%d: %d\n",
>  				   ab_ahb->userpd_id);

at some point the "ret" param was dropped, and this now generates build warnings

>  	}
>  }

