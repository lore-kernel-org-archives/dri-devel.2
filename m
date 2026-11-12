Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083960A2604
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dxL+38Ni;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GWn+VebZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A8E10FF25;
	Thu, 12 Nov 2026 08:56:40 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E01610FF2F
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:56:29 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC7isEd126041
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dUVtyLCTGUYG156kQ1fkWYumru+iqol7EbuNNIFYg3o=; b=dxL+38NiG8MbeOfn
 d6aS/acBV1QL2GM0cSBT2zvhDdgYEIyt9EU2f3iIMN1+5SC4YYfxKe22pT/21smo
 /vZuhgeiVy6ZHYe+qSNBzebYS8GepbNjSnA1Ofywm+BmCXcgjMalKwT97cwkiZp0
 5yU+v6xSGWtH6ZGX0vzl7m+lYs6469ZywnH8izxsAfV9KCzisA23ptHToE5ZKXr+
 JXCYsQrw9Yun+RlhJTUo+2eWHtCcttBUvv5nRt4wbiDufWNr8VXIxTeY0FLkfc2V
 NbGuugQQ4iaoBV5al8CwRSnaqK5Oq2a+2yUA8zDEcWWqEzi8nxJQn0X2+gsgmV3O
 huKwRg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9a08963-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:56:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-533962f6bc9so3873331cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 00:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794473787; x=1795078587;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dUVtyLCTGUYG156kQ1fkWYumru+iqol7EbuNNIFYg3o=;
 b=GWn+VebZLFv2edomeJ94xrnJDqe335PnJZgSH1hlK4Ja4bNDWJSR4K5RYHkFg0OJwu
 YuEInIFvZamd0saXwQKynhNIZ4IUSZl8VJDpL1ww1CabOh25phsIzpV5yEjSm3rYK7cU
 ImTaUjTM+uu2g8BxeuU+JzV14QWOTtzMbB7R+OW6GaY6IM3xpLjtBpZkbjfTPGKjfuXK
 uQszFjbxvE+4RyZYqhiJf2+bmEDN2rvu4M+wyYvWjQBaKDxNTuAxlXFXBRrRgNfv5I3j
 rJvW3vJsSgyvnENYD5Fi5LWTurwf71hKZurfwJrYxnHc6os1KCY2goEiFU1+cf5jOlbS
 DlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794473787; x=1795078587;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dUVtyLCTGUYG156kQ1fkWYumru+iqol7EbuNNIFYg3o=;
 b=VERBqtDPWGcDoKw/RYy46rJBCiDgI/Xw5XoPS8YU5L9x/Tc31L0kGZLu3dWJy+HhFl
 Pvscaz2EQxT63mywDREUO6h+uXaQ1mO5r1vRL33hxd17+2OC8kCOXuWmYqIcakDjXtIS
 bth/5PRqQFZzvvOyvFLO4lmO0qJipIcw+4HZ52ZEbu3noekZ9ZuhIRvjb0kD+aB+Y9BG
 9G1NEy/nl8ezFjGiWU7zcbTEULYFp81FhYuM7gKACf+EJr3p/Y3njsT+98lxSNf2zH0f
 yjygcFVDzZy3PkaDz2m2dqN2/AUcbI3PHI5w+lH8n8wJTfcmH54mP+Ue4nnkuZ5iyk+t
 NIUA==
X-Forwarded-Encrypted: i=1;
 AL+hErHRwRf6Hl6Huqq1zXvcARgmF1tC7EhBN8Ew7sA5tV5H0AYq3Q5BCfETEV6y0zsUdY6lEM4QrivSCVY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+BA5sKhddW072CaH0DtIFXJH7pG2VTI+ZCEH2dLVHxvWDgIkoL
 aBAuYYsBUpYnHnBbPqpM9H41XXVBK6+G7rc05ZvQC3SFUg98IR0FkgORnBqKIz7dGZa8KbhJzYJ
 Dr5K01thnsOrzxqgfypymuy8puO1mZmFpmGnl8pRzVSN4zc5wSqDLDsV6Avm56qGh0XIE6Z0=
X-Gm-Gg: AYBFou2xilGRlP/UVJupd33hxH06FLhbUs8eI1AOWQ+pOWZd2K1r/6gSGBY8mmndSnz
 cnaKRWSN/TNzHcfH1FAjz7k/nhe8PSCuZ6Lx46oxROAOX+WSsumEQllK07I/I5IYLT0U11FaNb3
 tra+6eyFIWY5//dIPRe40yE1B1/4mL7AS8vFr/YGiGVmtyLouYdaWezIYQBXmHPSVoS5WrDIOHW
 3J+lryfNa9Er+EC8VV6EVZTjT1YKLpqbbE+YwxxJY6HKRrAczk0JQ1K/AMzno7DZ29XULDdkSFi
 quELy7XVOi/l8vP+DFuRbvpjhiG5dUSsHJkR00PwI6B2Ph8r8SBSgEC+wt478sYqG6tYzmkAE5G
 hcA8na6gLpIXWiimeS1J/PNK6pUdGUV/otkDe6N9aNuthUBjO2ivBkTXx3iQE+JywQQ7vQiw=
X-Received: by 2002:a05:622a:d0f:b0:54f:7ca7:1292 with SMTP id
 d75a77b69052e-556c1775341mr91984101cf.5.1794473787360; 
 Thu, 12 Nov 2026 00:56:27 -0800 (PST)
X-Received: by 2002:a05:622a:d0f:b0:54f:7ca7:1292 with SMTP id
 d75a77b69052e-556c1775341mr91983821cf.5.1794473786802; 
 Thu, 12 Nov 2026 00:56:26 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7834cdc23sm1471774a12.12.2026.11.12.00.56.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 00:56:26 -0800 (PST)
Message-ID: <141d09b6-8635-4e9b-ba50-3c5f352bf045@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 09:56:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a8xx: More nonctx list updates
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261110204732.531432-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261110204732.531432-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: q3810lyXGkMeLz-bFUbWAJ2DTfkQtBaC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzNSBTYWx0ZWRfXwUy0wtGVExTR
 UL5G3VzRYQ5e4rq7t7PC0YM7ck06FXzYA12Fej6YJij69BMKCqwZhdZzJTXgu53PX49TYu+l/vf
 fGWbmG9gFTXPQc7SI6q5bbVI2+UfprjxGbfjcyjkazbprNJ7oiEzXlUU5quZsFmya4MbBUiTb0s
 zAPL6Rd5Nv9UfD0fEJnbTnK5RpwMXcPUox1GPr5J0EsYCc38MQXJYRWKo6L7dW8qgJ2LJhqLIXR
 BiZDVsOa5/I9praBOhqaIAZMuE6vI8lCrWa/+8tZAnlfs5J4Qtfaz/gqj3/9a4IEF7UQu6T/ELM
 qi2StSDwPrZchKyvUdEDt9YKbh6uGz3ZpLIo7QTXXA88945vp4T4DTIhD0mawMBSfAqP+eQyyGL
 1ENZZv0aEyNDdvNa0mD6oOIxA2kRkTyVKC4JpB0J3koZsKid5tkIMzZWzAJupTS38FhintskW6J
 T4xUt7KxvU0qn8+NyQA==
X-Proofpoint-ORIG-GUID: q3810lyXGkMeLz-bFUbWAJ2DTfkQtBaC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzNSBTYWx0ZWRfX9cTzQsF4IzTA
 k+85kK06cPhZNqLie0atqZ+6yPhfS5FTRSZMXP6BTTEj9XXlVrQAoQIz5gPLqdaA2heD4Fy9LuY
 1EBfggCWpste3RHRLYQFyEvBRY2cTHA=
X-Authority-Analysis: v=2.4 cv=COG/zhrD c=1 sm=1 tr=0 ts=6af57f3b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=aXd3jGBJYShpFBMRRZUA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120035
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

On 11/10/26 9:47 PM, Rob Clark wrote:
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Any dependencies on mesa changes?

Konrad
