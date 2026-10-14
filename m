Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2604FCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8731010E1A8;
	Wed, 14 Oct 2026 18:27:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0038E10E1A8
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:27:14 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbJqi3642820
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=g/RKNRbsq8PXf930rcBL/2CM
 oGPrp0BdI9lvBbzy4Gg=; b=Ux9GeFgO2wkBTCUNhbjOFpbxK8LSNDU6mTlf8VDT
 /rC9URNBAlNDE5I71v0buO1XPiiC9qZgJH2E6mI/OQ1iok3Ey0ER1iYspA8rTnIc
 3/uOU3s/OccXnPJvcCvKybseUhVP3QqGd/3JW8va8Qq28wdPwvVsap2RU8fj5Qay
 DpOyDRghI8KTteFfqEv4kihen9gS3SqSpMi9PbgiuY5Ves3rIDdoLM0fkAsBe1he
 WUog0661hAxj2hf0lM9t5witXSGZ73/bLx65d94sg/8FzKZQKhmUo6Y3fYNbb9S3
 IHzma+5ZhvaeCDn/W6oAp9pFNsZs0O2VL5X7SckCrVto/w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha470aye2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:27:13 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9197553d398so14512246d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792002433; x=1792607233;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g/RKNRbsq8PXf930rcBL/2CMoGPrp0BdI9lvBbzy4Gg=;
 b=TzzCdS1dBzpO4Ji8RUyP/Vuy5wwWy/eECOvclhBJIso/0XJ0MR4lNkJ+xdb/pBXlta
 ltyyYfaYWgsehzfka9OOQYQ+ZppAj1paJ0kVmw4Ia693LIZXdpapc4f4FFhuKgp3KQ9+
 ZOSJYJUxEWEFpR2r8fPz9J70ezh/Y6k/i+cEn1NQd52EK5ViM1bb+2m8PWwGeIY994dM
 cRC3FmFdxInChCxWqJxhahdvneksr9HahpVemmwC/UqPPDq1Q4kH4GCghRgIs9PpLQxi
 u9jendXi9x6NJeIclCQ8U5rA3jzeVAws5pujvyiE0SRDKf7XzKd9jhlIQFrusyXLK0V0
 Zcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002433; x=1792607233;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g/RKNRbsq8PXf930rcBL/2CMoGPrp0BdI9lvBbzy4Gg=;
 b=lhj7LpwtSPYwdYML9PwmNLoFmmYpyxRJnh8cHOVykL2cwDagjRe2jPH9IYRZbzoOPP
 H4co2RBj8D4atg1FUDwP96x+JOUZbiDBjh11WN+UaLiCZTyRah9bfnZr5VKClHswUD4O
 vraRadh2J5ikzRy31tsr/Ex2qLTrMHwFDZcSRG989GfY5G5FmI7E/vEnDbT06Joo+zQ8
 QSDJMThdDdBSN0uSlwAEIqxIdfhUZFROar6+b7v1XxS/tDHWpxTrM0bdbzAKGUQDZyLQ
 3cQD/YgXE0gSv0Z36JD4RuiGHE1e/yypadPWthqQ9rC7J8IhJ5CLLhk5O9CXADNyXg7d
 4gBg==
X-Forwarded-Encrypted: i=1;
 AKwUvByq3HwwRnYU5vOO5fgg3xi/GWcf9tnIzfuhpxIIZEJt0P0bBwmX+mGVqpUt9uvaxr0GN5SBKfCOhxE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKt3NZCtCFTrZcG62SwzRR149U1ADwv2BuU5h9pdnpJfJxMehk5
 cWuDT9gAAjY3XHqo7+0FwcGd7K6K6Nfl9REroYimbPjfKwIEN8t7lLpVZtudLFxe6dT11NGnd2j
 h97IhKi7l07ciUrCNEkQhWOEJnBeKj2kvKPRgWvRdHhfaE1tESkgQUAVqF/yJVJjs68wXf6k=
X-Gm-Gg: AYBFou3cVIdl/xvS12hxep3NJvI03LSgH4fW0cmxKbd7UaBDQMzSemLoK98Od8eCbA9
 BCLaouys4/li3WsPhiOlUqRILLzUd3Fjm5SPGoJwKO2xZAlRGaPZV4h53QYsUK6GxObuJPl0u15
 No+55S9od/mkDVbi+WFvxVpb6VQMIyDHkhUwKgspufhjr379DqjQNnw0Q70XOjjeZfSQ5d8ProW
 bqj9iWDtjx1SMOTV2AqwjTkCyi5pe7xwgVngCI3t7nvMZGM+ZtchvNNbHKPmBrwridFgnwmlEHJ
 FyjyBzkOfmZRJlyOgiKivfhBCLipbB5VzqsrcYm8z7s2v4vacI9R0TNrT7qlu4C8iMkR7uFsnXQ
 M72JFa8Yb/idivJxuIdt4+wcmY9jjV0SbozXsGK+kMdB67Tt/b9s1qx6Ze6w+V3vxK7vcfzevr7
 G11ZZq2QEktXkh
X-Received: by 2002:a05:620a:2855:b0:93e:6f85:963a with SMTP id
 af79cd13be357-93ebd2064ffmr2483206185a.34.1792002433112; 
 Wed, 14 Oct 2026 11:27:13 -0700 (PDT)
X-Received: by 2002:a05:620a:2855:b0:93e:6f85:963a with SMTP id
 af79cd13be357-93ebd2064ffmr2483201685a.34.1792002432458; 
 Wed, 14 Oct 2026 11:27:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be33c12ac4sm825167e87.2.2026.10.14.11.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 11:27:11 -0700 (PDT)
Date: Wed, 14 Oct 2026 21:27:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 16/75] drm/bridge: simple-bridge: Switch to
 drm_atomic_helper_connector_create_state
Message-ID: <bsanzndv4kc7dheubjifod6y34v75l3xj4jniatvjqliwpjf6l@xpyps4igpe4g>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-16-586c9c026823@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-16-586c9c026823@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX1UAZ9A3yOb9M
 n0gqZGhGt4Wwoumv/Pru5GlFHte+lTWFvJqyYZWxSyfZYV1tSgBH922w/aNBF+/HCKHSSkI/xun
 WCMqPaODLaqVZ4mHonLsNHct6B4KNvgnr+f90q6lPFSB0ZAudKDBACnGMgb3pYfXhX4UCwcxJKi
 h53VpmKq5s8X+Ob46sJFlQTC7jyDNRdDBVYeikqSTfd5pnbKNKAfktc3LBK+pANxoYhBzkLNk2p
 pMR2JfWs+zkcxyMWJcpXK53JGxcdcgiu380XyhUl+brzyEo7f2Aiiqc9MhKtl6X8/LVzTldui+b
 nsyhuaqeZhqZxX49fWdm7IGKHPjOIyy4kMXSljOPo0pLdjVoP0sV3jxfLCZ00Gi55stO4RQoGy0
 AirR13o+mjc8Sggj0ens4DaYKFFBHUBA6dP+duvcTwPoVv+eVkSa5iSsgEMGM6/dAn9MCf7fsCQ
 UTH4tHYMjhwD23PUWDQ==
X-Proofpoint-GUID: PoY9DoaqQYB0Ipqpkh_0m4JR-cdJ5XqO
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acfc981 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=5SmR4ZfugbDr7p1Jwc4A:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: PoY9DoaqQYB0Ipqpkh_0m4JR-cdJ5XqO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX//Hx4ePxwzoG
 V7sxuREn3PhGm0nCTyeyI4S0io5fGSl7RgvNrzo2d2a8jhtaFgJCgzvsMmR+tx+yvph263wnkYj
 A9oSBKhpmopIY/T5bkV34y1dd2jnlMQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140073
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

On Wed, Oct 14, 2026 at 07:26:39PM +0200, Maxime Ripard wrote:
> The bridge: simple-bridge connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
> 
> Switch to drm_atomic_helper_connector_create_state() instead.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/bridge/simple-bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
