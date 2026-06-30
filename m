Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4D5C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E1910E1EC;
	Tue, 30 Jun 2026 12:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KKnkbgGq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j1lqrF90";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67E8510E1EC
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:35:06 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9n1H81573447
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XbxXKmb6m1o+wu+br6lLzlt+6G9oYy2IEucIolB22Mg=; b=KKnkbgGqOr6Axbi5
 m8AFO+/Jphf+KutD3yzjJBOBGMRnZBe0xFfEDCpHsmiMPqrNjMgEqDLg5As+APA1
 d8qxQEA9OWFnuHHrcNzvJN31S1kOhgBbhvh5O/v/NANPH686ogZ+A6f0Jg11XSCu
 L6oDMxUpi66Stm8pQ73m5lflpH04VKTeKA0zFa1EGW2Iuhg6ljJv0qoye7xW45Dd
 HGtzYmxnVhiXD4HqcQrgDjuP53UqQiUinbMagr+sEQrcnIqU0lXA3SKbPhm8FgXS
 fJ6ZJJDxasvRRXyPxZS1CTAR6hpiohrzlxjtTBOBierePcL5Z5NKnDlfpBqAH/vm
 wze8qg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f468626t1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:35:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bfe75b7dbso2951971cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 05:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782822905; x=1783427705;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XbxXKmb6m1o+wu+br6lLzlt+6G9oYy2IEucIolB22Mg=;
 b=j1lqrF90Tcl2COwIfedwOu+gK5B+88BJyuG/OGHMkLJvePHO9hu+7ycUzijOc/H6ef
 zzMyGAPilBCk51qbv/owGzIj4jR+pLfS+lU+aX6/fLM4dYtqjlPG8pRnxw+40K4rjaIb
 uwKLvil9YTaU7SK/tZhmt5qRDcBBJQ1FOo+ye9hZfwVDnBv1VBkGtKb6r0UETz9B1dkt
 xA8EQX1CHJ01pJy+vT+fBbH9VzF3bwxyBzPGrN0dzNDmYwLRiDeKFF3EJXQXRck3/K/5
 NFDkQt+fh1NJ3p/d29DJcGOgj0rFr+2UpVdS/9ztEhRe8zCQFxiNPNZx2EdXhP+QmU3T
 RBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782822905; x=1783427705;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XbxXKmb6m1o+wu+br6lLzlt+6G9oYy2IEucIolB22Mg=;
 b=HNO/mmGCPMxiGjvEz8GxErWsjY6mzsi1KEtp9Mwi3r5czS0Khv7VDJV9ZPFpCYIHMi
 2YyFeTIKLqeQSddtavXkOiYTvXwE9jPmUGWx1C2+cWQ3egu4eBqjcHhXv2p/CxiVUk0A
 ZD1mE1oey477oiDy2zi0bDn4QAamP9MeWiWyPM6HXIyuH6vMEUmYsV+7YLPc1Y9HpnEl
 2EHQUUGDtAlgs5wB8KNrpmRkdOh1OHlcPZ2lCdlBB5pxj9R7v5z/avVje6HyPyIDby99
 UmRs7U2U/58Ol7vVXZ19vspR5G3Hr10NzRAkODtQDfuIa/wfd0EImFmZ1xKaqXAisblS
 QW9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ezH2eNcHWOU7puqtWd0HoSki8sbh6EEgwKvhPCSYNWL8zDpjpkJmmE1TjIOHGco4Lxg8V3T7EYLA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8EStPHWB9CFAdOsUZr0DAV/pxW0Lc4CJpErGgvif3s2ZGYj4p
 YpqlATFd2fjlLK8XwfssMshbGYi0ozk5IWqzEq0HsfC3TXW7TL+eTi8JhnpUSXxkkyQASxUQFtD
 sPmDzVF1SFNO8qb2OgMJFTrdmIuaFpCBalfpsVsQe6aNBPje8lDCJZtCxPTaOom1ZtmnaSwQ=
X-Gm-Gg: AfdE7cmuVeOQK27CqUuhGXsQKDxYxEKapL4+izc1VK+iLDLaz/mFMr9yFIcyBOhU+ll
 LHsV2gUatc9L4K9lBAJw94fyNPZBBgN5oGUG9AShXJjKnatuk6OAtEyWqvQLKir8C6XKrNNC6gL
 OhwsH4FhdTc/e2DGfqsvLyJVdhryeeiK8YXDLj3gskEh/49wV/R63qShz+6fwcA647Q3MxhFaPy
 qotKMq5wCGt9LIx5HSNrhsikwDlN0nlkKKz932KZ8fL286sKe8Ac4fUOf2LC1cqbsPE/99Cra6G
 bJW9mWQoaFaA74Y4TsBRKo19ny+0O3d5CFLJ5ygIFA0+1kNkB5ZR0SvOdHg5nOZSD4UtB1G565X
 INBkFSGwA19W/dpNqwX4R+Yq2dn6rE1dLTiI=
X-Received: by 2002:a05:622a:a1a:b0:51c:1744:edf0 with SMTP id
 d75a77b69052e-51c1744f08cmr12928941cf.9.1782822904804; 
 Tue, 30 Jun 2026 05:35:04 -0700 (PDT)
X-Received: by 2002:a05:622a:a1a:b0:51c:1744:edf0 with SMTP id
 d75a77b69052e-51c1744f08cmr12928611cf.9.1782822904391; 
 Tue, 30 Jun 2026 05:35:04 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1288f4c19esm117506266b.51.2026.06.30.05.34.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 05:35:03 -0700 (PDT)
Message-ID: <594cf827-819e-4262-9dff-a35c7f69f86b@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:34:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/14] remoteproc: qcom_q6v5_pas: Switch over to
 generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
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
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-5-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-5-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VDgM76moFfEdsLUZYx22Q9K_zRejPVh0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX2fkOoqVdbqWh
 kD1xf5GkYHm9thTMpde7n6EYKhdqPTzQE2+CyFrF4uptVDy8D2B2V9b+Abwo92At1l6dw/WGqG5
 qyqVYF0Uj6DYSHBg3lpoUHE8jJaS2gW1tXReVCnOeVoh0cyHeKRP1yhzMM1D/HiNZZkS2BJMIve
 dvvEezSf+3fJE9EY4qK1b7g/P1MITebvRAcJlaY9bSuOWkjrUpAQymniPAQSeounN/EDf9Jf2cK
 VEZvVQEeRuBW8KopB4kYz7yL4ap6tI4uyPIfVFxqYj39JBH7rkpXc1v3ox+8ZXt/D9JEELldBqd
 9nTAl9vD9gvVNHoLYcVdGVajV02DUqmxNW2AfxUbKD3Sl6d4UXh0byRmzz1JWbaI1kkVlevPbYX
 m+XgenAtMBWo6PIdrplespu3NNyokTR2y/jLU1exSR5rUBpEM+p9W/Hv4ImJmKTBOpSZ0WQCf93
 rEEsRgBVDrIOAkxdBKw==
X-Proofpoint-GUID: VDgM76moFfEdsLUZYx22Q9K_zRejPVh0
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a43b7f9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=JRhjOG_OB-XQkuSI_8oA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX1bCtrdU5mVtD
 zlUDJ+mMzDPU1imbDq+JDmYV4EhQwT3NuiN+k1FIkdOj9K4H4tNBZlHpVKUM0ygiRJBNZZZiOKW
 bRdCADLW+W/C3hN1rhq4ii7h86VvhbU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116
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

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom_q6v5_pas client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Since qcom_q6v5_pas depends on MDT loader for PAS firmware loading, it
> has to be switched over to generic PAS APIs in this commit to avoid any
> build issues.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

I assume that the leftover qcom_scm_assign_mem() will be handled
in a separate effort, presumably through something like FF-A lend
on the backend

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
