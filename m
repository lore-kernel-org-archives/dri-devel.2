Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB290606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R1G1GkqS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jo+ythmb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0367F10E507;
	Sat,  7 Nov 2026 01:08:22 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D826810E507
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 01:08:10 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Mo4tB1119415
 for <dri-devel@lists.freedesktop.org>; Sat, 7 Nov 2026 01:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2LT9f4/r07l
 EFqji6lCYM9PWfKdD623UUCASE9CcMk0=; b=R1G1GkqST3Ka3ccrGX+wXtlKxYX
 SQTS7LRp5zNjKl1excZLOxD/eOaOlRiWe9xqIHPoyNXsu+mZpXbIKWkfxO6giJj9
 FCgHKhjWndS1kuNKyRTbv/BPlClf6VlrNZpQozDPCr4gutQnn0GRWgzFGZpq5KWq
 DZby+zgHicIVQuuLXeXTIH7mo6Tg5/r/G1rGJob9QNFd6GGZ5fRgUCzyJLbgilZO
 GOP3EYrwgxgD9twElnSp4M8CZd1CSUffbZIULhYA+AcryN+YuyJs2To8iAElxSt4
 UeYktTVFt3Wqe99TpCkYwQcTgiDlDcTEKcpgxZ+V3Lc7h83vbG9b65wJQzg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsn03ryks-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 01:08:09 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8b12b209c4dso13713767b3.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 17:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794013689; x=1794618489;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2LT9f4/r07lEFqji6lCYM9PWfKdD623UUCASE9CcMk0=;
 b=jo+ythmbGUEWfJm2wXIFMeNBSkNF62K2jkPzvfz+pKm5vkaznZk38Lvx516AJUtVAD
 +x7FC6Mj7un6MB41E13Z0u/fie2QO4cP6cHK52zyjV4anCqiwxLX6Tg5E4nzT5FTOhKr
 bedKXykdNZmzy/Nh2e6ROyzgpvN+JvALGnkIYjD98XonHDDa59C58SmEVCldO0iV8C+8
 IDa2kv52ncREkyuKwgx8qRb1H3iXXo2nRZL0PG/6yLBHg11HiePjdm7/725kyAdUV++z
 Gm0I4/ppTag+e8Cymk8nn/uC74Fy3LAzeUXktU1wXLogJ5ihRfwfXpsop4zns86hR0ue
 5h3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794013689; x=1794618489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2LT9f4/r07lEFqji6lCYM9PWfKdD623UUCASE9CcMk0=;
 b=JpFfcjBHyNHoUVFMRnku7lQazJfKtz9b4lOrbSogf0MZ8hv6JZDIeXSs7C0Rp7VsJU
 ksiCnDzYOSa9e+ac9dCNXYg5M4LWevGeVKu5vO2RaWjxV0W0akVbW1/TIVgMdAn8535W
 gV9zkAfElI+MXab9HnOShN6x8H4MetEZK6h09ndJXUhRdqPjgwzMlf4jVMOrpFrrCaM3
 br4LJATrxHtExoUpOstz5XHUKaWWk4sBdMHYIkVtX+1ISTdd2WVtFqDREvUZxK3ER+cJ
 VZg3NCWzTuTKdVn/mE8wOuD6N/B7JXvu0Mk2vFKdn0CDQcyJ3EDxJ89jnqbLDp/bYlQO
 SmFQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG827Pqjr9UmQHOLXUYPsV7foFQdBnNB+r92LRjh0F9x1H4IxTh1HoODkTeJzfVrX5HCCIsPd3gJ0Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z858sp9785jUJYfl6JE2dI1KdhXTf4m5X7UjG9kCyH5gUAAuwYy
 GHHIkp2oEROhBeAxvigthu0AcBLT4DtI9xMEY2z1vgnDUju3a29b+gBmRXNwqYe2n4lR1MRM9lb
 OrzoNFMqoYCgUNOl2BG/euk9rArIyPB4Rg08vuSwF2UQSyCPTBGr6VYZ9gYYJnXzGDusaTtE=
X-Gm-Gg: AYBFou2HElcmcDBgUkstPq1QKy44NvZAnIiN9HdUNNO5gtrhJeQUv0DG7u3mJUsmRz1
 J7urtaLaR5C+7+oRsFf2pmWu9PIFliPNXOBIeS/kTrXX/P2mW3xPAmYI8Y5OGanUgtCM+7IHhMs
 MKXX3RGzk1oJ2xkNHc/gsFfyVfaE1GgRTbRgFjOUsxeEYMFGrkWHo7X1nNZUw9sqethbm6I/ELQ
 6DoKi5fEeYGVQB/ZX+yOvFPPGL0xpZaBgsjYF790t29b5qi9UOwXy4MRtVWeH56vQbnZ0sG+0En
 E8pG8MuIAXJc5vE5sNBkOXuMO8cNdgYk/fzsg2BIcxWG7n/pJMaaFFYPH8yOKLFOSFzZhdL1g63
 AMH+MNylMNUdJr/Atk4UkmTScu1/teZLE8FhoLBDXQvxX1XbaAsh80zJ/zoNBEHt0CApwEBhMA6
 qu0OTwoKrn6DoiqGkQcibIfPwUaRBI+XP61g==
X-Received: by 2002:a05:690e:438c:b0:67b:dc56:caa5 with SMTP id
 956f58d0204a3-67c145cb402mr1178070d50.114.1794013689016; 
 Fri, 06 Nov 2026 17:08:09 -0800 (PST)
X-Received: by 2002:a05:690e:438c:b0:67b:dc56:caa5 with SMTP id
 956f58d0204a3-67c145cb402mr1178062d50.114.1794013688417; 
 Fri, 06 Nov 2026 17:08:08 -0800 (PST)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c134f0b5csm3091934d50.7.2026.11.06.17.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 17:08:07 -0800 (PST)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_bkumar@quicinc.com,
 quic_chennak@quicinc.com, amahesh@qti.qualcomm.com
Subject: Re: [PATCH v3] misc: fastrpc: map ADSP remote heap into remoteproc
 IOMMU domain
Date: Fri,  6 Nov 2026 20:08:00 -0500
Message-ID: <20261107010801.3451213-2-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027-fastrpc-kvm-iommu-v3-v3-1-f3cd5c030c78@oss.qualcomm.com>
References: <20261027-fastrpc-kvm-iommu-v3-v3-1-f3cd5c030c78@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JMSuIMKb c=1 sm=1 tr=0 ts=6aee79f9 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=WGrctX7s3ODQAISolrcA:9 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAwNCBTYWx0ZWRfX4LfZG1XMm+GP
 4cHZROB2qoC+MMvKuphTIBuxheXEle6+Oh+dlab+DtzSfSw7AAvqhvJtWV2aP8rwj3FjKG4z8ar
 DJGFhujqyZmK1bucULSTrJYpBRar00E=
X-Proofpoint-ORIG-GUID: ABLHtS_V9W0R_HScLoVcaQ-i06x3YJ50
X-Proofpoint-GUID: ABLHtS_V9W0R_HScLoVcaQ-i06x3YJ50
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAwNCBTYWx0ZWRfX1pIjxR309C8P
 LWLh/Ih44v55qWYPGS+apXwGJDdh2IQA3XgKu41+P4Pdy3nZP2KixBKpY69JH0CO+UeNDLjXYZY
 ICKiFrYXDf9nAr0QwaFgfX3UQ1LXmRpXuKzaxbumvFfPz0c6w4vhgEvBJtFqcsihTi+tB2zTmbN
 4NZ6mAldDv9DT/8tl3cSyDxWsA/9eFNikMx8WVonUZhY1nNj3TrSfBYqadPCFTHjdUpa5MwHXuY
 oDJDRECEN70xNK2gLzf7iYomJQCLi4C0qXyc1XdQoQ2jwzxryqSg6Ybb8OEjvvWDOiLwm8EJ0gD
 uCYUOdMNxiwJMl+jSU5zyFs015hX0s2GfxKORax/nuI0tDuEXSZQVcyCXlgtQ67iAzppku89B5Y
 nhQcOr/NI3iTW/0CuqOxii6ZCDl+y4jhGBPSahIjY7KOhVPE7aaGewNHRLkwqKoK6PDo3SGMqha
 2i+JUhUn2HYFwjeEQNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
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

Fixes the ADSP SMMU fault on Eliza at EL2.

Tested-by: Tyler Baker <tyler.baker@oss.qualcomm.com> # Eliza EVK, EL2
