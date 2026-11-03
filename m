Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB5C606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ey660j63;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KsCwR9wa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0436110E7E4;
	Tue,  3 Nov 2026 11:24:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D27810E7E4
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:24:47 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3AACAY3161604
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 11:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QqlVyg+4SxHyWGbqD6MEOj3gqhmpTxKhd4H5ol0BuKo=; b=ey660j63CcUOVg5S
 oWYK/DdDV3WsySRYf0E5QO5Vgvy95DfpqC/6EpqafrSfHCRlFaJZeNgmfCDng5oy
 oNcvREz1COh1Ca1Uxvkl3Qey5W/TFaeILIjJ/hrwM8uVt1RjKvJDMdGr8u2UNoQY
 oxfzu2x9sZ3VuzBgYUW5+rojHzjr3FIhtwkXcmGAGw74yTE8+hUIVLCgqPVe47/r
 O+NjunEYBh1vd/JSv7QWMPGq6eLFp+MTbmzvrWgDaozWpD6e/IYPH3YM4Xo27oW0
 9mJo5E/wOSDP7MHkBoLjz7TMMuJnY37nUu1Kto57iWv15sAq6gxwj25+qWt1LYN9
 FfREgQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq6m99yr1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 11:24:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5476f5bd009so4672161cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 03:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793705086; x=1794309886;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QqlVyg+4SxHyWGbqD6MEOj3gqhmpTxKhd4H5ol0BuKo=;
 b=KsCwR9waY6TK71I7PhW1gbUI+z5IBmyoIRID28xFV1DltloUv25UmWNoBzqzTPD7on
 TwRd8rpWJu9n8RXqbJl1oISopZpCmrGHcSybIUGhyatTsgPPPfuhbo70dt4DCo+jU9gf
 wC9qJDMe6ssyXt9SI17HRtzB2azjFVDjTYGH3gUpQdVgTTYENFBP0DEnzyN4XoIEKN7Y
 FYyldyzLMgxamvwuieZ/ojAcLoY9uyYHQ1Sbglxjnk76NEHa0LROCO6xLDnqCWN6IW4b
 BF7Q8RxcRbHQLOqaukHLehOb7iBtvrBnsKCGtWZKa+aHlk3BQSSqYcshD6GuFAJcC0Em
 ph+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793705086; x=1794309886;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QqlVyg+4SxHyWGbqD6MEOj3gqhmpTxKhd4H5ol0BuKo=;
 b=Yqqm5pGOq/PBToUQ3bgXgxaPtW0hLO5nqtq/kdWTpz0+0gERK1vE83oeoFtZg0NnSI
 Ew68NRaBokvOcZ2MjXm4I9krhsaRiFZXhGY6/whokGWYeSwmU+h8VIORbcA7M9HkSn4A
 Oh+2Z8qt+zcF86XGZKd7WU7FfRSnykNLNCZXNS0e8s0vjp22EWiLoPwUG2V/eTYtw3BK
 VDFr9S0gba48BOF9sOV2dmwmPQISJfag/6S098n2tsvRzi86zkr3bxWQZvRXHDvqEf1C
 Hj8mqMkcI1FlhRkkWyHu/WFtOBHggjjNLZ9NEdwBIdFupZtTB9NXo51ksG1WFjZSYIN0
 2T6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuDm/DdGjsyEC+sNUGje6PMwd7HKlYpUIScOIDnD2vN4aTrzIoIoTisWxEoQ/aix4C8CjQcw4eyus=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9nHyWB4cLNZQ7UzIsW2U0Ea7tjsx2LDqj0E+bMcFq83PTxY1kh
 9ENR8fu4W0CErROVfUQTbq13cseXfQtdSTblZ4BR50Kx/v2ZdLcpfEnIBgN7KVbiAfE4Il9GdU5
 S6EGCbphgdGxro8ZtQ9U8RPCLCmkf1uCBtY1m2lWVSgxB4vL11MgNOZCD16GDFegHoQ1JbSM=
X-Gm-Gg: AYBFou1FEXOxeUf57RuMcbFrsQ+nGLS9soctc/XKlRwo+lvulK9IRqgk/geUVY9e9L4
 +ai0NhS2DvfbOAgi3l+p/fuW/PBV1XbBoTM1iWfhtOASIlLm7745hapqqOk+RWNwn0lZ0mTZMUv
 pg2kmuY869pSYo0D2Y6PMgdnFjlRfSP+d4EM2HRNR3GifUyRnTOIwRBdMnHFyjRYO38HCQblcwP
 xDNV58RT8qrGgb/ZFvmqXDVrNlsXUq3Zu2W3PSbonE+pEkOMtS+b9ssiRGcbYTWToQ82iK3A5ng
 NUh4OguMlTlQo6nAWTngqTMamwphJK3lBYc0cmBLCGQamhQbj7fKOhb09d8QB4kmIWkQPEZaads
 MFq+5UETIyri5jb1S+VBrT9qofxSTAZDgKuHUgXQ/9LQ/bGB9t+jN+PUaObLOFGfm33O2Lg==
X-Received: by 2002:a05:622a:8447:20b0:543:18d7:1823 with SMTP id
 d75a77b69052e-54318d75457mr189595431cf.4.1793705085513; 
 Tue, 03 Nov 2026 03:24:45 -0800 (PST)
X-Received: by 2002:a05:622a:8447:20b0:543:18d7:1823 with SMTP id
 d75a77b69052e-54318d75457mr189594971cf.4.1793705084848; 
 Tue, 03 Nov 2026 03:24:44 -0800 (PST)
Received: from [192.168.226.81] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cebf3ec91sm76164366b.55.2026.11.03.03.24.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 03:24:44 -0800 (PST)
Message-ID: <236ab115-51a3-4e2b-bf1b-6f775c387a72@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 12:24:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/msm: Rework IFPC disable
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>, Sean Paul
 <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
 <20261102190010.720443-2-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102190010.720443-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eSSbZzapCM7IQ1bJtbziHMrCQZ31xTVX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfX4DZrFUnZ+LKo
 Z/tO/U6ROga/WLj81+UJ9c1kTzF56DrcC7dRHqFaY6fkmyoNKMZcxFSiOZNCizvOCKZRrqvnihC
 J97VDQQJBQl9m0Tx/iYs2NT2v71gX6o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfX7vCXft6MzLOP
 yVHfy5UYp/UBUiUKZmT9uUQPC6O6cgoPq2pztSLMvZS/N+YIvPzViuL2KGVfvKf8ZPxMMXM8hXl
 1g2zFAGWKF1+c89CJ3QKl3l/UWy7BosQSAWisaAwBGQqwADE6+hwpBij7Prmow6vLzmd6M4ZeXw
 UNteW1G2g3rEYhI4ykgWH9XGpUr7mI6cAFyPgIS9ELrCRLI3qRtXJSIemrrFT/1RtjiZ7M7i0qE
 eudp6oZYpp+2Tsh9UgYenpbGzbtoRl40aD0fgXFVAZDpC+RMNKS9Ts3JhVARuhGfl8vkRT1UuqZ
 d6f427LYZDiOPcfDzSl7dUT7E896D31a+gCRzDRfhzRi4rD5LtAlyF5i+qHCTP4Qjys/I/dcs+I
 k/20EtrfJBvtE66Mux7jOPcdLPOTfWESSHh8zJEj/nFwKQjlKm81yKfLpJ+U11D7kZzsmI3+1TB
 48VOfnFP34TuwNgc63Q==
X-Authority-Analysis: v=2.4 cv=C7B8WgP+ c=1 sm=1 tr=0 ts=6ae9c47e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=td5gT8Jxdf4Ed59i9cUA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: eSSbZzapCM7IQ1bJtbziHMrCQZ31xTVX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030045
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 8:00 PM, Rob Clark wrote:
> Previously this was coupled to SYSPROF level, which made sense at the
> time.  But there are other places that we need to inhibit IFPC.  So
> decouple it from the sysprof refcount.
> 
> Now it has it's own refcount, so multiple threads can vote to inhibit
> IFPC safely.  The renamed gpu->ifpc_update() simply applies the new
> state by setting or clearing an OOB request.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Sashiko still has some comments

Konrad
