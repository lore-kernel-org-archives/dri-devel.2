Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB46606A31B
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EIv8tbx6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HEBn+Z6R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723D110E14A;
	Wed, 21 Oct 2026 13:20:16 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5CD710E14A
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:20:05 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBg92c1568332
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=aSnzuw64QaL2ODuF7dIoTHdi
 PuBaqdsaTTJECpYAR54=; b=EIv8tbx6tXPAcGXLwoHMp83UmNhsZWHR/l9I8HDi
 4/NrazfTe4cn1dw9qZPNikqZsw4VVrGPrY4VtSEFy9B6EJYk1yQ+z1v03RCikitv
 K2YIJ0XBiKWbLJwtOzXCYY+SYkCcsRUwgYQ8nuVJdN1UTbWR3t6Lsyk4iRLagU9X
 iwGJ0sXwcyFwUH+4ANIereXBcz7d8bV63FMhwxx9w5IKcrZbrbm0x8MD1BoQOd1M
 Wv/u6WWzBsPnrYV5W0cH9JesZmgnCCTV8T3s+GVT+4io2QwEiMSn4FEkY+DU2lS4
 e2QI7TEEg5n0OPk7FoWS5Dm/se8LLP2qSKvoCQXVATJTVg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4v2n5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:20:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9308eafb465so226322685a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792588804; x=1793193604;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aSnzuw64QaL2ODuF7dIoTHdiPuBaqdsaTTJECpYAR54=;
 b=HEBn+Z6RkUbZEWfdcuHphrP5xoRBNwdf5RtBR3zgPkquIIBHSrBMMCVRBbTR/YZr1K
 Q2kmXqYLcGWxq4iMwKgBtZ/8wd3rqS/p0iBc+G7w7WhmBZpkVfsfxwPXUedytGVuDDhz
 Fjdr9zcUEg3Lp/lAH3q1VrGOUFvn58xZe0hU6M2O2XD5LX887qvL4rrx3WvkXdZV4XPW
 Wl5mf0v0RmM9V6s2zwilFzYxcgf/1op73mdOlJHw1JeJNeHBz549eK0MA/DMqIJsQlZx
 NVZY0+aP0gf9/RSPLbdu+LTj1ayYowRhd5f6o8eoYnYDr7O54LawMaui6SLENKQ6eRRd
 PtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588804; x=1793193604;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aSnzuw64QaL2ODuF7dIoTHdiPuBaqdsaTTJECpYAR54=;
 b=Llm0TfZwaxPvjRzQUJ14NqEX224TDYYilYxAmPbN2kLAQh2diqVHkSoxTVEMA6LM2+
 nv8N1Tdo4sPyo5zgOhrQunyGxK3HjZTmhBlqcYP32zqGX2u/83yIOADGZ1bxVSbVuUlb
 ItGyis2HLuenVpmAbWjd+lTpM72xT9P5/tVucPvC+4/ACFoBpuz3rw4XfcNpzZB9X6zU
 CWQZFoRLemDKiblHbNzRvnCaPuVzs5qMEnWnmPcLXNkG/7vZC9gCvpTdR3IXnpJg5Ja6
 BWljOIBF0LQ9Ie28WEU6w8Ozs9UiCBb0uwTdCr0XPvLc14kWcJBZI+WjnpzfGUq9702F
 nVbA==
X-Forwarded-Encrypted: i=1;
 AKwUvByRPg6OJby46ihbJwOYVKFXXShsBZJtHCIIsGfXmxuz7MYcWd5Hz9r5fNhT+WOIMGb1j/kafbUhsnA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKm80Y6E/kjXrtY8FoAJuCvn7vikhp7ODiuuFvZdT6HKX43fZ2X
 aIi6tkPsP+g1Rri5VZFL2491zzsZwzTMWksKt7LfYXh0pr819gxkkNL5hX2g4xboqRDuqetsRZl
 uDzXlCTOjjQEdKxPbZOghqe033TAHke7gGV/YQzsgKhid2FOxGiR3fkMSjQ+EyrOS/o5Amb8=
X-Gm-Gg: AYBFou1dBIxHmr+rxNb5v0YBkydx5mVt5Fm2A6l9+bRIct+GrUt4F4HksRIHOrAupaF
 iozPfTSnpnS2UqV+dh/NytylmxydsuwcKy8uL7g9Z1q02Fjm8A49eY8qbNdf4lHWs61xVwYMMa2
 OlV/3Gzp2OpcaOZlCrSwYaaFH0JH00SVqZEAJQRUNh9VPm3TuWwtwuwC6nJ3ir1ovWfYrIztX7t
 3WXdzu/o5wgdxdQMOCCnPAJkeBg0xF9UvdkcL6yA+Vfmbm2DToGsBwStZazigbMt6MJf8fy9twb
 hyk3DbtcndeLjxGajI10QBTlXoxVie5jZJoDyfAPUdvC0Jaj1f+iZ+E4M4AWkXDL02uGTtmMMX8
 uMUF4zQpCM4FO032V4u+JSaWB9e/1+nwHxaMYKWn8wqDs9mgMmHh57THNc/0jguSLptsy8rpwkh
 FQMnVMuxsOuYZi
X-Received: by 2002:a05:620a:40d2:b0:93f:571b:c72c with SMTP id
 af79cd13be357-93f57f66116mr409628485a.46.1792588803952; 
 Wed, 21 Oct 2026 06:20:03 -0700 (PDT)
X-Received: by 2002:a05:620a:40d2:b0:93f:571b:c72c with SMTP id
 af79cd13be357-93f57f66116mr409621585a.46.1792588803368; 
 Wed, 21 Oct 2026 06:20:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfa1224fafsm512832e87.63.2026.10.21.06.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 06:20:01 -0700 (PDT)
Date: Wed, 21 Oct 2026 16:19:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 0/8] Migrate PAS clients to qcom_mdt_pas_load() and
 qcom_pas_prepare_and_auth_reset()
Message-ID: <zqu4sweaftstbt26v2u3ajzv7snnqswuyrktm7t7k5gh4zi77e@d6t2fpsinvxc>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <ce3f58f7-f500-49f8-89cd-611d8e1ac6ac@oss.qualcomm.com>
 <20261021130735.h7t2c7txqdfohrs6@hu-mojha-hyd.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021130735.h7t2c7txqdfohrs6@hu-mojha-hyd.qualcomm.com>
X-Proofpoint-ORIG-GUID: 8DnlwqNDldEnuPs_AGrV6jhpLFP_fe-v
X-Proofpoint-GUID: 8DnlwqNDldEnuPs_AGrV6jhpLFP_fe-v
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MyBTYWx0ZWRfX++lXDqOjHNtM
 id/I7th339pgGZxZFS3P61y3zYBHZunpc9uKN8Pu3gBruSa1wHx/dqhmEemobbIchCFUvmelQZP
 vPpd8Dom0ce4LcDPdDlOsIJ+q1CA6X0=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad8bc05 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=LTSqVt2n0stEVfQD8AYA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MyBTYWx0ZWRfX6+l57JFEy1m/
 kYEMRfuoA5ocuv+c238ZuCt/dnn5oKlCr1xaIE5I3GaBd8sdvIG16fa8+7Zw3+i+IdXPJ41C/QS
 EfmsJTs0eg+9LRB5+kNExsDp+h0iFr23Nww7vmG1MyM68yzto4f6WQZXAPS6qbJp6Q6vgpVUdsb
 SOcvqyeXO3LlghHqXBTgLe5XIN4DNDPEQxnbozrgOPDbMAej+nlODM9RziuXo7Nc7KBNVYeef2V
 eKt3sMk5F8KIhyawTstXrgS5VUd/GXf9fSOytqsYiIDOjhlMkt7tFEOGt63m50z64e9cG2Z5J3q
 19ImO7+HOcFZ574qgTTnEKEwVONh6vdkBPD7kD8E3WoI/VR7qiYXXqDxsVyB5q4OnxOJMa+v/Zi
 TqSG7HYsDNK6+H6+sQ/I9JFzcE2VIf7iWZgDXRBrkzCs5nbQq78r0WEJblxd6/eMvLDhL7KIO+p
 YsYnb3kTelDmH/VWIkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210053
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 06:37:35PM +0530, Mukesh Ojha wrote:
> On Wed, Oct 21, 2026 at 01:32:13PM +0200, Konrad Dybcio wrote:
> > On 9/25/26 5:57 PM, Mukesh Ojha wrote:
> > > In preparation to remove qcom_mdt_load() and qcom_pas_auth_and_reset()
> > > public function, migrate every user to the new PAS context-aware API
> > > qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset().
> > > 
> > > This series migrates every remaining caller of the deprecated APIs
> > > (qcom_wcnss, adreno zap shader, iris, venus, IPA, ath12k) and then
> > > removes qcom_mdt_load() and qcom_pas_auth_and_reset() entirely.
> > > 
> > > This series is based on top of although no dependency as such.
> > >   firmware: qcom: pas: Make MDT buffer retention explicit
> > 
> > LLM has the following comments:
> > 
> >  1. Metadata buffer (ctx->ptr) is leaked, and overwritten on
> > reload, because qcom_pas_metadata_release() is never called
> > (patches 1-6)
> >  2. devm_qcom_pas_context_alloc() is called from repeatable runtime
> > paths, so contexts accumulate until unbind (patches 2, 3, 4, 6)
> >  3. use_tzmem is never set, so the shmbridge prepare step never
> > runs on SCM and the commit messages are inaccurate; TEE gets
> > a real mem_phys/mem_size change
> >  4. Not bisectable: patch 4 relies on the NULL mem_region
> > handling that only arrives in patch 7
> >  5. Patches 3 and 4 don't apply to this tree; iris
> > iris_detect_firmware() still needs mem_virt after the load;
> > the base of the series is not stated
> >  6. Patch 7: NULL mem_region now means "map internally", which
> > weakens the -EINVAL sanity check
> >  7. Patch 6: redundant second ioremap_wc() on top of ath12k's
> > persistent memremap()
> >  8. Patch 6: ctx is set under one scm_auth_enabled check and
> > used under another, which is fragile
> >  9. Patch 2: the context now carries the full region size instead of
> > the MDT size, which matters if use_tzmem gets enabled
> > 10. Patch 3: stale qcom_mdt_load() comments remain in
> > iris_firmware.c
> > 11. Patch 8: no issues found
> 
> Thanks.  Will address them along with Sasiko's one.

Just to check. Did you verify your commits with the lockdep and atomic
sleep debugging on?

-- 
With best wishes
Dmitry
