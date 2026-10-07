Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FE9CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D23610F5C4;
	Wed,  7 Oct 2026 13:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YRElo8ZW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PagfONFH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7916610F5E1
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:42:01 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697BVAje609947
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 13:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=KGUO9Rm/3Kp7eJz0vM+BTmpU
 efwN7FAzKqUEkIaj2gk=; b=YRElo8ZW5cnbpy/eU4UOhguAjnN+1T/XxF3EsT4u
 l2iEvrSTdeVMoBMIk0IiMzR0IZCIEYcqx4bkP0GjDH/GcTrFAexAgC+kv3kb7Oee
 e9dHcoX2q0h1nHv2vNxOjd2Irj5WdxCY9+o+7hehip++iNh0Tkx2aJhE7Kuf2run
 XfAFA2/KDdqLn5v4Ie4BWiBHUx4wACTwGzIr50tIEGgjjP9MJHySOe9t6YDgXVZq
 AbBowdkJU7egs2X3bFePu86mByRvzF8Iy8RGDTbhmQpoTNHz+lonQeu3Cg5Tjn4b
 QaTf4G0vaTEgPZ14GEhwZv+PJZqJ71QWNkNlm7AR5l4cog==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fc59r1b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 13:42:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf6c528aso655544985a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791380520; x=1791985320;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KGUO9Rm/3Kp7eJz0vM+BTmpUefwN7FAzKqUEkIaj2gk=;
 b=PagfONFH2uAABf5k7UYuVe4g9jxpuvGvhOQ7J0q3mVqyTIg2ZDtxEJ34IZuBNQz5PO
 WZZhFmvzOh0ojlNiVgTtVYqXQ9/0y+4QIrs1WV7aDU7UfcKzlX3MoowRdR8FykxmwIuS
 Ezsd+IqexgifJ5ys2wXarJ/EQCakwEzCrIJ7QXzt0EC0KxneoOENaChm+F4Paf3lx9M5
 JmaFWPtDGlgaZm4XZ/vwUwl2wPkn4Eaks9+kd7i1PuvezXGtscf49SIte7k1JBZWpNiw
 OYRiMG7tw1oQlkk348Q1yj6lxoJreI5goXJPcqZhSUtIhtPOxHKbZo74xVdPcM4TXccK
 ie/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791380520; x=1791985320;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KGUO9Rm/3Kp7eJz0vM+BTmpUefwN7FAzKqUEkIaj2gk=;
 b=p0wpB5a7aaSu1LucTnwIbG5RlwDU8KS0ur7H2pK5r44Vo22J569SlZ0p5nfXxjeDtY
 Cp5Mix1l7L1wXbpeDu530s/v+XE1lIUKOZshD+WrJyeggkp2MBkMTzbZbZRYQfepciXL
 f5VbXdSjPd3jBbVsUwKkJGLfgJqjPE1KEWZmGA+pn6hvSC9s6eV5IG2y4AfhASP1vuUL
 /bV84XICG05AIpglk6DnEOyFIZwWKNarQnP+VNPm/rSYCvHuIxDeYq1FegS5pUhDK+1I
 XSc+2lH11nP3q9noTnWhU7Ml8/LlGCcIGtedW6UZX5FbAtNU98g+r7cM6S4YRGQWTyyb
 b+TA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTOMWSVJ9a1bPIEvwybldxq99hI2LhMt0swDww2d2CVRU1hdjUT1YeFufZau7APyucTn+zb9FdCmU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mxd+p6LKS0qAhEujlrqAZl0QHWCVhF3NciLH81NX4SnmSDeda4
 aTS1iDH+7D9wB5V7oEGPnoUj5ZuVEGiqY+1UDRed8XVHbC6PRuepnZZevPE3yNEGb64PDpsjwHq
 naoYTGpoVreM8/usxzireb+m4Y+f4+ujoNmqp8nrjzRR51li6FrdSvX021dN/jmJu3sY8GLg=
X-Gm-Gg: AYBFou1uO9e3eOQPhDbXok5jOud1qSwo5elkGMtcGGGY2J10Wros8aNDOrAvDsJD7c0
 x6kdZtsAjIKLX9W3st3nnzqCayfhB17KwEV0T94S/hFzMq45LKB+iuBKxZ2VLlYtMDlFpcfWtFF
 ux440JIMuMlrLDUdeALi4vauo5qkEM5YzP/qkGUcJy++1lR+jf6Rm955/0YFbwepGfaiNeNJSji
 5dBnjvnIrsb6dhV80hG5gmyOdo8pkx0cy2JKDtAK7bXDbOfAUACAjSYf1EBrMdpQcw5S5UBq3lW
 CQRSvLSaH9GizF14KQiqC6j1AG+Yq+R87WsGpRnBlEanExAu/VWjoMzg8TnlYMA5KS9OPJ67A7u
 JZDubkJygNcqaKSyLdG4vnyaSM7pHgXHtlLDgOrOvyDLQ55+AjHozoxrDA8EBLI6IO7+mS35OqS
 RUcgY7EF00Oouj
X-Received: by 2002:a05:620a:2b47:b0:93a:2239:4ac1 with SMTP id
 af79cd13be357-93e9b7424cdmr451575085a.32.1791380519894; 
 Wed, 07 Oct 2026 06:41:59 -0700 (PDT)
X-Received: by 2002:a05:620a:2b47:b0:93a:2239:4ac1 with SMTP id
 af79cd13be357-93e9b7424cdmr451569485a.32.1791380519340; 
 Wed, 07 Oct 2026 06:41:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcd30a959asm48293e87.84.2026.10.07.06.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:41:57 -0700 (PDT)
Date: Wed, 7 Oct 2026 16:41:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Joonhoe Kim <26rote@gmail.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, yongxing.mou@oss.qualcomm.com,
 yuanjie.yang@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: add the SSPP rec0/rec1 blocks to the snapshot
Message-ID: <seuzkp6defi5uft2uhgclrt6iltd3sj2hrntvdluesqqtoadmb@zp2zolf4qf5o>
References: <20261007123945.1694-1-26rote@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007123945.1694-1-26rote@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NCBTYWx0ZWRfX5wkazLvcMLnc
 hEMasQOKSPnAQ6Pm0Y0srDDQN2owDS1RSAgb99drpsOBAbT8W/Y+LnhGorUZtPx8a1KEJ6MUb8n
 5SEM2uehM3XwkalWtz4iw1Rzsol+c2g=
X-Proofpoint-GUID: 2ytHo5i4X1EpZlT7_Pou612tNKuCbyfp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NCBTYWx0ZWRfXzCUxC91Zm8hQ
 qmE2RcFO1BiUhznYKsTl8KwjCTzzpfLm2fwinOBqERW72Wpeo8+thZPutnCCVuwcRCVlzwAJP/E
 reNb6ULtbdcO6a0xaByMWaE6n5likQ1X+5ghbB7bqRJ8tb8xVGzY7qXYGXhb20P6k0cIaw7awWL
 tSXj9RjXBRrdfcXPFLhkOLr/OrdhUAowVQi5sXgcIh2QfgJECzMHaQzQMlj6IJGccYv1BqsJouD
 g6bzcrRrMzyTtYwzPbxHFn8PqrPMHyyDyGGm6yExqZfvqveWgwqA6lja4wOk/aSBXlhycBjZtVJ
 EnKeFKJ3ITAB7/Ye/IxnFn39Uuia9VEarhN0I6aZymay5uZ5kbGScHX9XuIyASMQtHsXUMgCq1K
 uktpSWFuUf7fGMyvy1U1PDstiFTYKwLq3uyBOfXe2hAE9LIFxRDEx2s/c+qyPXHjX08GbMTRfEN
 y9kv1WvQsv4uaKExzxg==
X-Proofpoint-ORIG-GUID: 2ytHo5i4X1EpZlT7_Pou612tNKuCbyfp
X-Authority-Analysis: v=2.4 cv=a6+lZkSF c=1 sm=1 tr=0 ts=6ac64c28 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=s5JHMdqm-UuCYFehMJkA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070054
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

On Wed, Oct 07, 2026 at 09:39:45PM +0900, Joonhoe Kim wrote:
> On DPU 13 the SSPP block is only 0x84 long and the fetch registers
> (source address, size, format, multirect) live in the rec0/rec1
> sub-blocks at 0x1000 and 0x3000. The snapshot dumps the SSPP block and
> its scaler and CSC sub-blocks, but not rec0/rec1, so the plane fetch
> state is missing from the devcoredump and from debugfs dri/N/kms.
> 
> Add the rec0/rec1 sub-blocks to the snapshot.
> 
> Tested on a Lenovo Legion Tab Y700 gen 5 (SM8850).
> 
> Fixes: 688c7734002a ("drm/msm/dpu: Add Kaanapali SSPP sub-block support")
> Assisted-by: LLM
> Signed-off-by: Joonhoe Kim <26rote@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
