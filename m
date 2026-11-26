Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93353606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j+Yn3eps;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fy8B/S+C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C0411215E;
	Thu, 26 Nov 2026 14:40:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C1511215E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:39:55 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEV2XW3170948
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4o6hxaMULxHqbctzpcqZn0i4+vQqLZ7WDm3A2Ju/p4A=; b=j+Yn3epsXuvzCPA9
 f6uSvOK6O1ynXZLniq3rilBDaOAIjPc6utbZ4AKCo2J7TX/9mqFW+MXXrbp6q2yq
 nXKxFA4PlfnFURe+OV3GqBD6u21T8iE/Yo8kdu5QwCvriUZxIJ+7vYrtUy8DNoe0
 GlJdDmOqzdGVvocH838y4aQjz6tvtndnEofKc52pxQFC3pB+7Zaw9m5xYx8gF8un
 Vpp5hzlM42OfD5E1+1AZslQH5q0sO70x2UZmIHGCiyuxy9BPDy5Qgyu6XpS4+6wd
 nlsaVJZIoRP5sodiTeNhZLaOq8jx7H2Ye+opNXC9N1DPES8CRNi4eR0+R/fWDprO
 DZENYw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j66qfbb6k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:39:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-94993a54a73so63996785a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795703994; x=1796308794;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4o6hxaMULxHqbctzpcqZn0i4+vQqLZ7WDm3A2Ju/p4A=;
 b=fy8B/S+CdNveaQ4RiGhbm027fQ7yuvOMH0awauNWhaYYZlpIzPCxWHHnyZDko9cswY
 UiWNPgR3ujk1dGhHOsX0k75jyn3HCokm0WrWo0+fhmaFuXCFO6ZVHqCY3oOK6tRwJ6HW
 SpcuYm/9BEiWLb1X+Ho4TKn8nquElNv7n4cOVQjKvrJ1STjK1S6aShq+Mq+zfWtK9xGo
 PcM26JVlrwS4mS3VAp0rhS5UL3TYVoxg3EsLFGIHqxGkJSlieRpxNiZZn0KvKeReNMIv
 8sHBGI6snn6+yyRxUMP3p24CrAbDVQFLNTYWsN8olJamhc+LUAatKxHxT0Kr6Jh3Cxzr
 YiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703994; x=1796308794;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4o6hxaMULxHqbctzpcqZn0i4+vQqLZ7WDm3A2Ju/p4A=;
 b=QCNYn0QUsEVNu6njCSV8CWb3mxGb6tY/Y4BIGnUfEoBqLv4lPpqwvMwpTshONpAb3J
 9yQqvD+EI2yCcFVVbYoJdw+ew3fESFEL16Hl2TvRJ66jtfnOxwCZVKc4134kwhWyHJZQ
 JtgcOWOKJokivQGIH+MUUQjARlqGrF26dDLgOmT2Tk4Zloi0lYAAejoYSoSvr+7FZfWR
 h1LocZbomEzAhumQsQd+nWGLpVxvh2vB8cfI9hdU4xFwEbFrNQWxbydm60qfR3okv5BY
 gVWwEbyvF5r1oA2zXW8iRbZAM5QM9fqj/y4N6QdIegwyZLcdHZQ3hILskMg2NMLNI/Fc
 jHMg==
X-Forwarded-Encrypted: i=1;
 AL+hErFvVirYWzFnCWU0aQi9gO/vS9aQuFkRQ1JWUhyIskFIvBkTqHU8QxuyZbN8MaBHg4vUMyYJ5nIx6H4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ihIBk2CK5log20JmUw0hzokurArC8SkqGUIEt2xMBI+dN/4hT
 Ki/Ab8Q5SvSKMpJxBFIDl0uEBnaMyT7Ot19h29HPUx4HpuF4ZkGitG4cmpHLAIT0EhgcERm7QGe
 d/US5SFWvDZvbENao0MRq8JIuap/al1gE+2Ka7it+wlgDVD1PjhF3tozT//WbDqdaTP4sOhU=
X-Gm-Gg: AZFdTZcln/af5enTamk8VvW8cPS7duMvoM0TQwabidMi8PZsz8KBtYlz31bVJOK8vuq
 XxbYodSV8jHyRfImHCibq4udABWbIXYpOW17rn1+SyhlWSZssY0MeZP9bjvemdJeVMjR4w+uF+U
 dVaWBziO7czKtgRE5I/pODE2jqqnXz1j36mKq0+z2fQDcnh3rdLUsSXAZBcIRr5TvYWTzGkITSr
 HDGgs8GXjzcoA9YaDsICH8WcMa+UqorhO+CUSsSPXvbfp7nhasixnCz3rSfIRL7JzuNx9tuw45I
 S6XyCyN3DMtwmUS64mREa2oyGraOlJrJBLVRJyZ0MgdA5ES+uJtUk1yhEeMbx0+pQwtQfCQ3/aa
 nkeERpuHJlBvg7ic4XwMbc1EJh00mdlYOkMU0Okd8jsKT4QBTcXHNIwPtHIqddN+MKf4phqI=
X-Received: by 2002:a05:620a:8719:20b0:949:b116:182c with SMTP id
 af79cd13be357-949bab698d9mr3428196085a.6.1795703994512; 
 Thu, 26 Nov 2026 06:39:54 -0800 (PST)
X-Received: by 2002:a05:620a:8719:20b0:949:b116:182c with SMTP id
 af79cd13be357-949bab698d9mr3428192285a.6.1795703994052; 
 Thu, 26 Nov 2026 06:39:54 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba36e355easm9326829a12.3.2026.11.26.06.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 06:39:53 -0800 (PST)
Message-ID: <bf91db79-ae88-4402-9b5d-bd797658d03e@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 15:39:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dsi: Fix double put of the PHY device on probe
 deferral
To: yzddmr6@gmail.com, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miaoqian Lin <linmq006@gmail.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261120-upstream2-msm-dsi-phy-ref-v1-1-d267b87d545f@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261120-upstream2-msm-dsi-phy-ref-v1-1-d267b87d545f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hC8Cr1A53zUG9g1w6ct9W4_5snCjI2Sj
X-Proofpoint-GUID: hC8Cr1A53zUG9g1w6ct9W4_5snCjI2Sj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NyBTYWx0ZWRfXz+okkHEiMl+N
 w7pehtp++P1bEZ9KisOVjT75cBbUpJhZ0kJXnyC3/ezYyyljp/CiOJA8Q091f+o8PvrFkZQPVC/
 ZUzribuNvMV7hK/c3sIxEMEUwY+NKzs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NyBTYWx0ZWRfX3StQDXWqAxdI
 jV84TRtVut6/yRlerPDAVLikVCsxdCj9OgZpbv3OhJkGerT7u2QlhsgLU4joPeCv9EoKKxcgxJe
 t9LbHNKzJFp/wRbEeuaTg39HuO9xP1OoY/u9f6Ah1NPKOK7cTSL0vs67/TfQFidSaDqqPyR+XPc
 YSmYGUW4V9rS3GqS9hIhIzcenokK6SRPb0K7YKzLFMzVS4WFlf//92ezS0bl2kILdbLDCsDxQcM
 IbpgS6k9z1zt178rDNBb3p7Q9Q5cihbMJdo3rOs9Hzt5/dEEKaHkWiJxQD3EsUPEZx8OIOgtyGF
 9fKIijQ8FhhETp5ra1xZsKi9Myg5I/2pF3U0sGs/l1yMKVFZCAFVnYYXroPbrDbx9hp3/VG3ZLc
 /OVnY2FaXS+TR32lSwckPmrgGTCc7ck6rxPy3HPJ4a+GZO/6qA+8+9B823XIkbs/uWbzTMgbFEJ
 QF24dsjQ3UVFEGXTYiw==
X-Authority-Analysis: v=2.4 cv=Q5VHcI2a c=1 sm=1 tr=0 ts=6b0844bb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=Fn84FyJqvcQcrJAY-HMA:9 a=QEXdDO2ut3YA:10 a=JkYnuvabuEIA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260057
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 2:12 PM, yzddMr6 via B4 Relay wrote:
> From: yzddMr6 <yzddmr6@gmail.com>

Please set a valid git user.name, we can't take anonymous
contributions

Konrad
