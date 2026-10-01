Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250BDCA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82CF510F600;
	Thu,  1 Oct 2026 10:13:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="meHhNfPX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HtD9Wpzg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 139D210F5F9
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 10:13:25 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xPL82887746
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 10:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FUYhHl20vJ4GbrkFUA2FDZPB
 lZ3YXgo1xmjRX6hONZs=; b=meHhNfPXIWsgY+h/0aHZAF5jeB1vH+Pq5ZL26iMu
 IyX6TdsUqgi58LbwWJyqwVIL0ZTytoH8dJGe/AnM9A3VQxF4AhJi9gV8YC8UW/dj
 kjd+D3i0afCca5XS2wB1oIphS3vUgqPfXPRM/hUyhKiZnmgz9HWv3+KirxMxGsn1
 j3ZaPcFapW0hNB+YNb4M+PSQnQYnn4UXM3piENkrW3N9dkCSxn6PR4Kj8RAmApiU
 Anqsuwo9kQgSK9A+p3S2/BGKvgokQwjkK4uEsVA78N0GHPjGsXj1hxkrFbZmX7mN
 3YZx4sUmxqjveF4JVt+/F5TeKSOGYuUU7eQ2/TCoJieDMQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136tmp7x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 10:13:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cc40759b2so9136085a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790849603; x=1791454403;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FUYhHl20vJ4GbrkFUA2FDZPBlZ3YXgo1xmjRX6hONZs=;
 b=HtD9Wpzg0W+n3eZ9fjW7a/2j0KFYQsQHkdu8XgBiGizvYFIifel1jsJhyix959Jo8d
 jCgoNiDOd+fpOoil7In2rRw1bmcZdxjpjR/OnXKnmaJJAGY70z+fqzpL8Wlk8smB4Zpx
 26TJK3FsKLpWD/YPAxJk9qPASg3nLbGwO+j06KooPVX2FJQomBoLhIR1njD9zvKWQUI0
 QiUVl9YySzy9HshjevCNJG/K4MKQRe02cQRV5alNpAq2KJynXKB5rq9i7BigWWVAXT93
 9nH65xaQgh26NWVSM3OHkBfMO75mxnqca7I0wAeqMI7zLhwl1s9xNPxgmd+XQyRHNkqz
 zWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790849603; x=1791454403;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FUYhHl20vJ4GbrkFUA2FDZPBlZ3YXgo1xmjRX6hONZs=;
 b=1uVohT10X4QtfPa8eLB/OYpSAYsavRDypn9BjY5/nkvKJpfQUz4uyA+SGl6b4Wz3WQ
 t1Ck+3jtFeJTJVQfH0u4ksLSMo6SfKuBa2nF46T2/vI7fLom7P6C3OplbV76r4pZGGhU
 gC1nqlU8nl5O0jVIkLA0ZdWhU2BvSdVAa8rmrlxYov/qdTZYyEvFeWMKcf5EI4MIhFNe
 ZrGemiEcKyeUg865omWPlxy/O5BqbPTwjxePHOMm3oqS4S2ALU1BI2o3Wn+9UzjHSjHB
 hwbVBR9NOP67yYk4yGZju0t2Srr08xLVIliefNyycy0D9tQVvtuSaG4tCf0+zWBavObZ
 IMLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBylc+K3IYGxNNoxC8IuXqK5ne08ugK0Homs+ipbJHFT8mIZDQUqR5xYl9kDaeHqZYOQ3kBFr6N0Tic=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ni48v6Mvw428Sfldu4EOWa97cHLbazi3cYobgvzyu/67iuo05z
 8Fp12KeYmScHEundg4LGKnaA1u4tcfkSD+5oDdO3gS89a6gIPNOrZgxXKpHGSYJvelHdp+XVBo1
 EJiTQUtrH5slZlgLiHMgBfpNYfghnXYNcXsnk1EBT6bjaifFdOHBqtl8BceKmdXKwkWNUBp0=
X-Gm-Gg: AYBFou06ZqFZa9Knv83Xuw9aSryBPghAvmmsIg8VvSlHsVjPIz+I2rK73A/D02wUD5E
 r65aABgnJsnoCDxYR3i/oAGqfOAcugz0DfXcttxj91bDxRxJrXtR4N8c+uHc4bAVuccEGmu7H1S
 LB2PodZRaxoxM5RznBUPyOXMcrsnLu+V+upyVRpKokGeEjr9gqHJ2xecXcx48JG7q3YppFlp7vo
 sKsEqB/ZVLm+UjGazKet1MzvxeDyKIv3mTyvruFAMQWUwt93qdTNhnbbp+visCmW8qcE21TmWg9
 pjBk08dhH/iAlBRK4U2iWKBvtjxA7Npo0Cx9Kn+P6EpksPPmw+E5pCi7FM2w7HZiNMLyPly+0Eh
 UEB//vtOmb09mvN4Cns9xhnZJbxpzOFh1haAXeXPpohqr8huZ5zcazimZo3niu2+in7J8/sElQU
 Cns2smeOhHB6br
X-Received: by 2002:a05:620a:c4e:b0:93b:d7a0:d9dc with SMTP id
 af79cd13be357-93ca97509c3mr740543485a.54.1790849603530; 
 Thu, 01 Oct 2026 03:13:23 -0700 (PDT)
X-Received: by 2002:a05:620a:c4e:b0:93b:d7a0:d9dc with SMTP id
 af79cd13be357-93ca97509c3mr740538685a.54.1790849602886; 
 Thu, 01 Oct 2026 03:13:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42faa877sm633191e87.25.2026.10.01.03.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 03:13:20 -0700 (PDT)
Date: Thu, 1 Oct 2026 13:13:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/35] drm/msm/dp: drop redundant config_ctrl_link()
 from msm_dp_ctrl_on_stream()
Message-ID: <ktjqx64psvfmnfk2xnchuwfjblb6hhweoxd24najvpsohnmive@pikk7gtqp6hj>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-3-4b81473185e7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-msm-dp-mst-v7-3-4b81473185e7@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXzFCzGj4cLFtE
 GXZ3GbeeWD6d22KwHBZmXm8wDzBp+5EUkjkwcdI/7YFES8qb3WYqtPsAvEuqLXKTswNGFID5bkm
 sDCalxNSRINAkO43A9n0bDu2UsBIxB0=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abe3244 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=xvosr8ehAfmB6sJLDpoA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: phqD_6cbn-LLbDoASxanAXeA8INQKQk_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX6FtMT209d27L
 I68QEybV9vO8rRNnxPzTJAx/jMyk9/komZneM9fdEQmxZ4p7omVs8mtTiw7C8RB6tJodtMiURf7
 SLUwkYGAxgqRwkUSDy3AmW2HMJJ3HjSeXxY4RWnM5V6sVk0tNEI9h/komGplNrB7iYzsjchNkfy
 fwjtzbJWRFZMrWyNojUxSJVprlYJeOhJdfaDxhGzKWDNKmMrXg9mNCMdA9ocxNUwwST3RWwsjIa
 206i+DBPxr08dQs6cJQIRdrblQweIIp8doEVUQ11Qz1+TvXf2ClV385VB3gylxjf/g2jtu8o4bD
 ULqZnAzH1RknfMdV9T0Jykr6er1F/13J646RXVzCkiREbA/nzMWVSchBCcOd0QcY0K8DQ+OHm7v
 TJLDlLyotAFGefwDEV9SgorVkEd+IO7kLUY7T9RRn5Tsm7t2JFO21WWU/xa5nlnsGsiRPc7wDrO
 B3bdeC6n7HxUu7kZM7w==
X-Proofpoint-GUID: phqD_6cbn-LLbDoASxanAXeA8INQKQk_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040
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

On Tue, Sep 29, 2026 at 12:25:27PM +0800, Yongxing Mou wrote:
> REG_DP_CONFIGURATION_CTRL contains link-wide state and is already
> programmed during link training.
> 
> Calling config_ctrl_link() from msm_dp_ctrl_on_stream() rewrites the
> same configuration and is unnecessary. Remove the redundant call.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
