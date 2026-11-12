Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDFF606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MtUI6b7Q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fdsdr1T0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE23110E61F;
	Thu, 12 Nov 2026 13:38:28 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B9710E61F
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:38:16 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC8uh2V4149288
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=uZMjiV5/PU+tMAzofbimEmP0pnjSzO4K3nywvn4aU+8=; b=Mt
 UI6b7QHyfXoOS6mthpt5UkYsrXFRFdOvk9PuS6cQY5NyGIuFYB86u/dqXUjXTtfl
 49R7eTNlkbSLIk03IfdrR58QxSwGLTlLIVmM93s3jdH1l7OPOhK5uoavskG4BUj6
 KTzGW+FkUKKyQvA5xiNbebNOtXwfnK8sRkGGwGmj41eb3wviOyl9nO8jEhr905kB
 vcq7tuFStdabpWVFZlSJYVJMCxmfcTrwYLrF8sO06RJib2XNDlRBXYMMDXUNldy7
 Z/f0DrYsWc0AnceZgHfq4VBvQ0XTAGQn5P5n2gVUygvbxl/htcC1uB9jOwaxUoKM
 4yXJBz4za3xxVUA2rwYA==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvxc63m53-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:38:15 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-469debb526fso3948782fac.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 05:38:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794490694; cv=none;
 d=google.com; s=arc-20260327;
 b=ZnZD/K9VEDYKTpDd4ONrtHxeQ+dmejhwxwRKnrdp3zxcagg1p4AWyfcN96HLqH/TUK
 rcSJmuW3pFjLN+1pVPoNFMqcGnsMRnxcbTw970V/ev90IlPM+Nd/EoWsjYlS91EM8vZK
 13SuyF43mFjABOK9cH1ldB6vkzKrP7n2s6rqj8S4K+JmZEskDeUH5tpR7xyCNnPTJimU
 EFoFBeknGmlH3qsYlkR6tVdlRBrQXGHvJnlKGOPhUnfCdYz2mx7b2pp+7eQXx1JUWt6U
 IXQPPbo8lnF9/GbLMG5WtfwOPyuHpE9c8S78jrk9a6hA2Lv8u9/6Tt/ERjGqnkvFcqFu
 IyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=uZMjiV5/PU+tMAzofbimEmP0pnjSzO4K3nywvn4aU+8=;
 fh=MV1rHui0Za1P6jB09Tn/Axech+2V98huC7aG/kJoe7o=;
 b=KQmkjP3yA+VeDIEPqyBrx8oZXB9uIHjUvs+PQGRIesoX93kw0N4dx0IkLkDULfPhLY
 uUSDMCIEhq4XJVqlHk991Y0vqfXWqAWAFhtuQyoH879mkLOkFTkrA3XhAdExdT9eju35
 SuN4TWn99KB/1byYD0/GSJirIIZUiiOJ/t/5wAx12VyId94UWd1BAc0N50RANCRS1+yz
 8aXgLiFQf+mGTicjvkwDMUGiuQ3eVze5srhd6cMS+xhB1bXjLkqBxt+1G0qUQIKqBytz
 9sJ7OhqqU67so6pulpIarjLwku3u5FUBenBpUPTo3ZHt3MMouyz7DOVUYVOvAGqSz6pk
 NsKA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794490694; x=1795095494;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uZMjiV5/PU+tMAzofbimEmP0pnjSzO4K3nywvn4aU+8=;
 b=Fdsdr1T07CWdrVdGlIUEVhDnpPz4hURF88mTskn2IzJ5YpDxAWJWq8jtmtBdr0YPBO
 EmPdCrbMTUcqgrNZcBxC3OtEPQV//NAgq/sQE04dRgdkaOqUCDU4u3wJfwxqz5hT/IqC
 jF/o75zhIq1wkCbejvK8e0ASi+bN8rVuBrJSBfcnzpxtcElbpJ3LqwajIX9iuzmwvQjF
 9ntCL8rkgNRfALQS4qcePnOSxQDCBzt0AxlR0cB7s/Kn4l3WmlXL5IGe9m6gTteyaByN
 mpelb03lLsYcX2ZlRxeS3+08rizQsdbYNDroRwA80SA1ZeBCO5yQo01wsMixQi7a/IKh
 Oi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794490694; x=1795095494;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uZMjiV5/PU+tMAzofbimEmP0pnjSzO4K3nywvn4aU+8=;
 b=HUqltLg57NvUqFgKdjOlYB44YvM5W9+nGeLwPQQb05ZBzJu3EBqxXSI5MQAt1jTwA+
 IS5JE8Qf0xgPs7VffSx9aV6yT5noJvfXIJP7lXyyg4jl+fsUrIYrPN4Ga9vsZ9JFXgkD
 ouhx/ZFaYz2yw4o1fytu72M2DtR3oSIM68K7OjLaxb7TvNCn64eyPVAOeUMLJ1cvsE6x
 z7gAJ3kmsRfL0bgnihWy0g/hHPgUurqaHJEMMfyT+K1ua7mqGNlxAhG5hZe5yD4hCWNx
 Uz2Oq7lG/oAO+fmM8O33f5y/AioocQP9EwiNyqSG43WDX0SKjL0Gt65yyGdJf6DJcL/+
 I4sw==
X-Gm-Message-State: APuU4Z9n+7R0sfgQWrO0qVLsoQ6QrLhV27aw/2ApU5PEF9zk4PuIqZY3
 UgmIMLw50K1bBOlWN3hmkt4HLUMIEeJ7WzqfHGYqYjyYYvS+KIMjBJ8TKYU/NcnmaUwY/pQOCpw
 kCG6EuM7sayH5y7y9YDaCKF3M3Vwj7sN6bGlLRfxENpbmJeb+FFK9E6bFEBDu3izbFJ8FsyeCPx
 0hHk5e0cQ/yAGG054M940NqFr4Ipc8fLvRr42G1AtzRzSnVQ==
X-Gm-Gg: AYBFou2tsnwwUYxDU4m7qO+11fRjM6mTJwBf8YE13A4ERcEadG6vK0Gac/CxV/WNUEa
 FKDMz2GKQHDtRUs0XY7DXpIhQ1igvccTt1vfLHUGskQZx2eKqI84/fY8rIxzGvQG/gv/q7OCkSC
 4S9BrggBWiu+nV8EcKKVQuD7kN/GSDEKISm4huUvAapgBgWK7jUnnk7YkpSUUPAmYPQK2wZzRqI
 6bKhcRrPAzESGnXFJOntg==
X-Received: by 2002:a05:6870:ac93:b0:479:47f9:27f1 with SMTP id
 586e51a60fabf-4ae46c5620fmr4972462fac.36.1794490694499; 
 Thu, 12 Nov 2026 05:38:14 -0800 (PST)
X-Received: by 2002:a05:6870:ac93:b0:479:47f9:27f1 with SMTP id
 586e51a60fabf-4ae46c5620fmr4972438fac.36.1794490694085; Thu, 12 Nov 2026
 05:38:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110204732.531432-1-robin.clark@oss.qualcomm.com>
 <141d09b6-8635-4e9b-ba50-3c5f352bf045@oss.qualcomm.com>
In-Reply-To: <141d09b6-8635-4e9b-ba50-3c5f352bf045@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 05:38:03 -0800
X-Gm-Features: AclHuK8IvmQSAh8MLCERgDgD1nk4EMGzjbERLsRckPKn8tpmXw-AAtPEd21ydVo
Message-ID: <CACSVV033yjfbbpLMOMtWbSGe9y1XjbVmveRGMFDu7VzaKAAd3A@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a8xx: More nonctx list updates
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: PZXVSNfob2NmeNtNULs84Dt7Auxezjof
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX0/Rtl3w2gAts
 sxD3s5SNRLbVktULxYPj6EHJj8J3yHzTBYszzPbt4rozlVuwD5r9xlN9jnUZmjuE0c5Jla8wgKY
 etQIaKelM0DL4AqYKFq0t/bcy7lFFsahbRFpbzsl+UVhAvQmYB5G9YjjVX1EnAHNehaezrJJWln
 ailTgXyGaldCOhUHKbdXSjAC2gXgDzotq9jcfAWfhdwyw8h52Pqc2wYUzSo1rkQiQGnKhZyqs0k
 I9p5Gv/Jbuwm8nfb9lOhf9zx/1yQe8m5ityZR9oEgO+N4FzbK2LTGQgiAKSKvhdos02K1718ycN
 rxIZq/20y2RH5LkWpskKlQFmj8tEZIZCH4NGXX/PHKQiYhEW0UKPKbXC4LxT/x2VIqbRH6j1vR9
 GeoY8h5ebq/LyDTdGLE9u7dR9TwE7b1TYJXpAMRkf4JG6vHWmBHAYfb/KV+UgaDmemjGG5CNRGq
 hjK52vO/xvPin1kP3Lw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX4VmPXpRiuzHV
 lAMR1Cl+0nx5M54FvxK3W+3CTOPnq61U1Y7fNL04gWXRXJSB1CHnJjaRYTS1PPYTfNcY0Iwg1yC
 UMK/ye0LvDws0zfJ6JxTKp5NByPjFJM=
X-Proofpoint-GUID: PZXVSNfob2NmeNtNULs84Dt7Auxezjof
X-Authority-Analysis: v=2.4 cv=O/ysLx9W c=1 sm=1 tr=0 ts=6af5c147 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=RUdMuCsKevVNhb-ASNUA:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120054
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
Reply-To: rob.clark@oss.qualcomm.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 12:56=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 11/10/26 9:47 PM, Rob Clark wrote:
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
>
> Any dependencies on mesa changes?

There should not be

BR,
-R
