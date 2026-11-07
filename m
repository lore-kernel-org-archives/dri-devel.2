Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B55606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 01:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nzvsnKf4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DRZ7VEd4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF10610E4EC;
	Sat,  7 Nov 2026 01:08:18 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F110410E4EC
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 01:08:07 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6MoHlb1732838
 for <dri-devel@lists.freedesktop.org>; Sat, 7 Nov 2026 01:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XqszqiOkBMd
 k1vvS7oxfstl8dAzvdx7vbMieJ9TUstw=; b=nzvsnKf4vSqy5I3sIwru73tIh/C
 PkLvqXCjrNMuZRvybGPsDiFnaL+MLmf/w/+fqiny32jbJ0n+3ffI7He3VoZE1nIm
 29PLZ0FYkhyN17eFrL9/yCjtsSl1XGWQdS1FWC3kaG3uDbeRwk3oZgguz4rgdSkJ
 Qvfe8QRetKM0dosQXmVFkRuvs57K7L2i7k2bt1BwfJ4PGYOawDLko4IHgVa1HI6z
 Q3xLqlTIuzyFu6k6tJ9Br4f5AVKQ6qdLWdDzMN/dKJvGVOlzHO+GyUZYXBNIS0HA
 xls7WtflYKX4odjenNt74HqjWWYx1cT9wBrRzh/Ii2re4deua6tzZoFO8rg==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsn0e0y51-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 01:08:06 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-67994010b21so2190230d50.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 17:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794013686; x=1794618486;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XqszqiOkBMdk1vvS7oxfstl8dAzvdx7vbMieJ9TUstw=;
 b=DRZ7VEd4ahOmnfkl8zqM8CnAZuda7xeYIWvL8moPKF0ufsxgRnfG0pTOaq4tFOpNg0
 dnH9G7AKK3wiCu2Q6fzmxINN3kPFQ8knPCr5LG6AhIGI1rD0bropaa8peqn+RD7m2PwE
 cMRhkWlzJQLBin5ufRJRzGFctXexLiaLHzn8jTr641lTT+MYCdU+IiGBUbcaHD053cxK
 Usaus8wdMSTl2zMSHm/YxBfKY4gmY2gjY68z5+gSRyQE3wPvDsypCGZKKSCdZYsopWbS
 30E7tv1tdMiRM4TMBFa9GluxvrlBuUuIUmRxIPYkiXH9n1WClKs0vS8dLhdrWo7bstn+
 gtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794013686; x=1794618486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XqszqiOkBMdk1vvS7oxfstl8dAzvdx7vbMieJ9TUstw=;
 b=yZ/dOvp6L2ocJf7jnAOemYTdxsF7WTdOd93HvqhGosg5x/9LhOgMzU2bU7kAgvgYmc
 7Poh4jG5SGg3+jGB8Ly4ngSzGABjo8Fd8+XGLprld0aiUJvxmXWiJp0D59pP8NIOv0hQ
 a5e9PJyX/qM4YFSbkFJRIctznnLiX2Vew62DZISF9erX4eeX7M08WYO73rW44lRcZ1HS
 21G72FwRlT43w8m07i0wygm00HQsemliuc/nncojna5kwWdQ6WLzHbIjnc4vbNs0V+y1
 qzuoHET+h6W4KQ+1ZhOCAQx9q5GDFPCVGNu1fuf3pWk/FSrdG0roiofu3gzmm05WQFiW
 Oh6A==
X-Forwarded-Encrypted: i=1;
 AL+hErGX+GFXJMMH+Ozm70liDC1sMDe3thiRq+T93NUSZI7QnkN/w9i8CtJ+IOZ3eMlbPRhgNrNxO5QuPJk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9z+kXIjt6JC3l8286w8l04vknIPapoM9bQrCEktVH6iHG107Ff
 InnE6rZu/d7sNRdrlAzcPVzacQonI7nrYsslPJIsOLCPkY7nIo1lpd1njGzs2cUQlxvIYJ8dVji
 HusY16BFwlyYhgIqM626Yeh0JPqEmFyIyuoYqsnRciMHkL4TNzRn/JS8PpJF3L+C9ZismGhY=
X-Gm-Gg: AYBFou0QpKLyWAywpIrUtiYR+OKRQjCeRT+0sAKwHc6VMsUpZc1wNuC/Cv+VJALG4Fl
 OaN2tcLvKiAXIH1ztUc6rkWV5VPbjpipeWOnwt7zSpiLA5ze5FXaeLldO57YyICqWvO665IC+z9
 Q4Yw8xp+qjoGpIX3dU1GphGePSSHAprNkq/E48TqnBY6Uv80h5+GSz+b+tKLnix09V/KxkmuN1V
 Xw+mHMEdXZGc1zB+D1gBkeKnnRwdzx2Cfmm+DNKUJKHe/7imaTxCUZB8ooJAN2Z2yO+HsjyWByU
 c+2etYujbI01KX+MwWoppOrqO6GxvSd1buIv/Y3Tg20UQkSOx08gwk5MSQ73g6dJsYbG7HqQtls
 00pm0TpGfsHj5ZnG9nXQLssRhoVjIvZlJeE+6sF+JSESDomgETjrHSZpPbUxP3Tpd+zAZ4Kfm3z
 oV7FTqLAIroDodZkVoS4/rX9QwqpfdKadaqw==
X-Received: by 2002:a05:690e:4814:b0:674:d78:4bd with SMTP id
 956f58d0204a3-67c1407f86emr1633704d50.5.1794013686294; 
 Fri, 06 Nov 2026 17:08:06 -0800 (PST)
X-Received: by 2002:a05:690e:4814:b0:674:d78:4bd with SMTP id
 956f58d0204a3-67c1407f86emr1633700d50.5.1794013685859; 
 Fri, 06 Nov 2026 17:08:05 -0800 (PST)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c134f0b5csm3091934d50.7.2026.11.06.17.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 17:08:05 -0800 (PST)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>,
 Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fastrpc: fix probe-time races between rpmsg and
 userspace
Date: Fri,  6 Nov 2026 20:07:59 -0500
Message-ID: <20261107010801.3451213-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
References: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VICYDCMCfS-fBB22jUAdX0u9rd8j1FMb
X-Authority-Analysis: v=2.4 cv=ffA4WEQF c=1 sm=1 tr=0 ts=6aee79f6 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=fP8dIGKjERIvVM-sKqAA:9 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAwNCBTYWx0ZWRfX6w0td2r7lX/5
 MCHsr0Be8+Ubippo5WDkvfqDHQ2HhvH0RRjP2TZktYJykWO/gsgRdaeGCfiSAVSD+vFkaD/NWt5
 o2zcc3RKrE+/8v6dlEkuGK/HTdKxSmPsdDlLq9308Z4lSJPYJ4+cP1nYfEyvD8FKtMswQYfVX+u
 2bhp95ggTsPzDylfG+FemjU7rzDv6kWrRSLS8PFQ+HFvaq6sDn3OjkWiv+LddAFjcXcqN9ekoJn
 n/7+WfNbNjCZAiOpkBETodgLKU4rpzTwbPpaxDDgMbz84vduxhqt5ivOUpT670++HJFklsPXJgf
 JgzevLJA8lA5FeRj4CYUTfmn1syphdicxxCnLU0jBBQsRng3W6NngIiGndfX8bOhCfqFYw61/CQ
 G3Ff0eYHb/gxR9INmE//++EVN/YqzarDvcYAvh3zuppjQ+UB+2viJ0hnstdNQesL20Q4DsFbAy2
 wP3HwPdRVSqf8xarDYw==
X-Proofpoint-ORIG-GUID: VICYDCMCfS-fBB22jUAdX0u9rd8j1FMb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAwNCBTYWx0ZWRfX0C5orj3GU/q9
 AK+l5pQM2Hf68nf2JgELHJtxpDMViv2ynGXMJEtFuKRt3X/aJt1rbGi2KVJi1+iYDe498jMhisB
 hvZS3QTYw5pXH8KOdt/wtjKa91Abls8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070004
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tested-by: Tyler Baker <tyler.baker@oss.qualcomm.com> # Eliza EVK, EL2
