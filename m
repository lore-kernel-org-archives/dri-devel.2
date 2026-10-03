Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18117CA5FE2
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D11010E6F8;
	Sat,  3 Oct 2026 00:47:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hr1roGXG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bxR2IYIG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 239AB10E6F8
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:47:12 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Ne20o2942635
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7ylCuDOkn6CBYsIUnQC9b4yfcmzAwShqIqn5wRMueEQ=; b=Hr1roGXGGuK/2Ys3
 PgGl76KQG1zOxNLlVCnQ2ynxWrck/9kbFwDuLrXbMEb2JZ3P+GkDVCVtD6GPC9NV
 vRDCRvrluqIPbORvCQxCvHC9ZIONz2Oqfer6oJkeA1wqpf6y0jhSoqCNv0v8VyOh
 T2nkJSA2gffkn2OOJgRLO+bWvv+mFCZ0A7f0AuuIXi0hEisowMdToreBElclx/mC
 sm2+HM55xwM4X5FpHniNXskbax88saef40RNKwGDLuCb66h7ISmvIh2ZGyjLkAcJ
 wiOf3SqvhKfw2zihY3tHz0NLdY4OsuFdKaEx4vmYm3hiHvk17GiJRffhwbapdLEE
 WdorOA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2h4kseu6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:47:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ce7a85f04so12767485a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790988431; x=1791593231;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7ylCuDOkn6CBYsIUnQC9b4yfcmzAwShqIqn5wRMueEQ=;
 b=bxR2IYIGwrSVMUFki5GPrtkKr3sJrihGK1T0n1sN6dwunJQeVmLZwtENYue4AKi6Ka
 nFD7niQ2Cm64T9rQaXgsEqgkmv9pS3vjLLiCXZ0iu30H2bTakRe0dPISwj7KCm4sgiVT
 fZTiebeV5l311HgQlYwZiM7sXQvMcU4090TxnKgsOzyiBGdwezZ7fk0G5ms4k0HQFab7
 a0LfvFOh3c/wQQPd2/jkQR+OJQy7TF9QiCQAWEcBJ+O1fuP1wRNQDH/3OeFzUEBTa3jB
 6Ukq8lQUnjxMU/4FGGWOrac8YGMnXDFz/Ok+cAThq+33tKrH+fOaKdK0kjxA3PhFrfKn
 reBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790988431; x=1791593231;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7ylCuDOkn6CBYsIUnQC9b4yfcmzAwShqIqn5wRMueEQ=;
 b=YGdXQ44DaOLZFNxTB5y1/Lj/9fe0Yn2P2n6cRWM7XZ2TFc19++5ZFx6VJdv/vUR0Tu
 DZHRioGrLlA+K67sxcoyOlsev9Xev/c+HfjzZzzheXwsAm4FFaOhH79UHnLo05qJ17rO
 VlFh+7JhAMD2l8aE18l3dqul/C9WEI4MezS61cjta8Vmgbgg4v7/OdDcISMxZQbLViDb
 F8AUq+n7/YWH1PyH2VjB2Fv3LwoUaE5caxwJBwJkHAYUg7U+4u8unNowJiITg8rL+FJN
 3MwcvSSFjNEqqaFKo6SI04InyA8f4XhJt2+fhtZf6Iv1FtehzR24oaubleJOW8xr8iva
 /6KQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/knIY701w4ETMUR4qn95kNVjuoH3bvBaRY4V2wwZ+wtw5Lfc7jPC7xeGO1IQ+BLhBzJsuYZXWMT8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kNwF4yYnfVuTZE/TQJ5gShT2vBMV2kOqKUr5qoB7KNVKqCS5Pq
 CB/+5OfCmWJQfuo4Ccl/pwCOw23OWjSK3RUTdf6NonkKLMeP1Xvwsui8n+U6Vb4lqXIQGQPHB+l
 3x/KyfiBxCBfnT9S+qp4awz6QmxwNWc7qmtnAsoou8Bkzrruj0jc+2+WlcISdOepsmUQGtGE=
X-Gm-Gg: AYBFou3HAnegVyA336oG03ihYT7A0sxLUdyp+9uHQjUmBcQjWU2iBsi066rq/boZjUY
 ySoT2oDi7cv3MjT0JbWqwfa5iweeIFwBT2C85jgXcegY3by29X73Hak9gTVsjdk1R/aS/96F1VG
 w/kOVQ4aXGCFLYj68jn78+rJDgDT8KlI8Xq3idSWeQsg0BYdnmS5976RkxTUCodG4JAs7p5TpgE
 oMPZulfqW0SuLXSy3MJOxfkAyPMZChjpRnIh9sRLzTCN3d25yGYnHOYJ2N5NTy1JFyyZREV6uV2
 JbE8Sfg/2wM0opi8UjlXl2y2nyZTb1tbBw1KAWYalRWWxcLQ24RXqMcqCU2lwVXcIwCT4rzWX2i
 MHz/vlDBZf1vuIqkIQy7bdCpEiWfq0D9NoQBVpiEcSAoSUcaohamEhp1U7AyDAwGIKKY2uNFecs
 96YCtt3fB4Nk81
X-Received: by 2002:a05:620a:8804:b0:93c:612e:9b51 with SMTP id
 af79cd13be357-93cf18a7807mr872505085a.55.1790988430605; 
 Fri, 02 Oct 2026 17:47:10 -0700 (PDT)
X-Received: by 2002:a05:620a:8804:b0:93c:612e:9b51 with SMTP id
 af79cd13be357-93cf18a7807mr872501985a.55.1790988430151; 
 Fri, 02 Oct 2026 17:47:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c71911bsm1160748e87.11.2026.10.02.17.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:47:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH v7 00/35] drm/msm/dp: Add MST support for MSM chipsets
Date: Sat,  3 Oct 2026 03:46:56 +0300
Message-ID: <179098834065.3641559.5174851000778073981.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G46JgNk5 c=1 sm=1 tr=0 ts=6ac0508f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=e5mUnYsNAAAA:8
 a=NtFGmenAaefONujONKUA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: Cb6TIuw_DWSj0kmgtaIRXzSwVsjBNsxw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfX7qPmPTrm7nTm
 lEj3LL57G3W6HJ/IXKh1k5oGLgxAmrd6ZsZIThreuvBYr7c9w7OcShjMVt4WIJM9yK5uU+fpCdI
 I5R8EEkKAMrBtLFYo/t7QyaA1A27BlWZKmMswJq/C3cUa+hZUQM8qiWKZOQNg1RjuuA1efLyjyl
 eajsLbROF2pP0PYC09JmPfM0n2rMbFYlAmuMzigFsDM7FaW/juDL1gL01TS36PYE9sSTuUeOEAt
 J5NsXIsFSFsojjXZP/0ekV/nHJJZ7KJL0tDnX0EzwX+qPBK4SrpXfPnkJ2whhElgK4eNcuMQDHB
 JlZBuhWcKt2sGwJe19grjYiX20SeBc4KPkfkE7ehmfw/dNMGILGrrvtj1qTiWQh6BBmNfmNDZmr
 8/UlCnsTzkH3wqjgtERFfsXcOFxAO/Mja7lb6Y+kISNzloNoud8eeDayWNB+d9LKDipq6VE+MS4
 x4e5ZxBYtmrx8s0B12A==
X-Proofpoint-GUID: Cb6TIuw_DWSj0kmgtaIRXzSwVsjBNsxw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfXz1Tgxc8GBZ5O
 MvSJxD8CJWzdwO+dOgWvJH1fiaZRZZEGT/Y3HtDmkrYlRwD+vceTqsgJcYEkCgucRj/StZiSU+N
 1M05vAq8OTeBlFRWa13GwiF0rNTktMk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030002
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

On Tue, 29 Sep 2026 12:25:24 +0800, Yongxing Mou wrote:
> Add support for Multi-stream transport for MSM chipsets that allow
> a single instance of DP controller to send multiple streams.
> 
> This series has been validated on sa8775p ride platform using multiple
> MST dongles and also daisy chain method on both DP0 and DP1 upto 1080P.
> 
> With 4x4K monitors, due to lack of layer mixers that combination will not
> work but this can be supported as well after some rework on the DPU side.
> 
> [...]

Applied to ttt, thanks!

[01/35] drm/msm/dp: move link-level teardown from display_disable to display_unprepare
        https://gitlab.freedesktop.org/lumag/msm/-/commit/1bda647ce61b
[02/35] drm/msm/dp: Pass panel to msm_dp_ctrl_config_msa()
        https://gitlab.freedesktop.org/lumag/msm/-/commit/642a8c954d4c
[03/35] drm/msm/dp: drop redundant config_ctrl_link() from msm_dp_ctrl_on_stream()
        https://gitlab.freedesktop.org/lumag/msm/-/commit/9582ac3ad673
[04/35] drm/msm/dp: introduce stream_id for each DP panel
        https://gitlab.freedesktop.org/lumag/msm/-/commit/ac12c30bc556
[05/35] drm/msm/dp: add support for programming p1/p2/p3 register blocks
        https://gitlab.freedesktop.org/lumag/msm/-/commit/90bc95ebb04d
[06/35] drm/msm/dp: add MST stream register definitions
        https://gitlab.freedesktop.org/lumag/msm/-/commit/cb821ad0df17
[07/35] drm/msm/dp: add stream-aware link register accessors
        https://gitlab.freedesktop.org/lumag/msm/-/commit/5e4a3f7b2620

Best regards,
-- 
With best wishes
Dmitry


