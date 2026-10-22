Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466A606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z3TQBkVB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eey9XN8w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B12FF1124FC;
	Thu, 22 Oct 2026 11:32:53 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31FFA10E3E1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 11:32:43 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M9xpjW317739
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 11:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=dXEU4fNstySwei7nZv6T8myc
 xD11pRJ5qnWjwSzk+X8=; b=Z3TQBkVB20a5qG7u5iAzniVCA6vhy+g7rZAljzZj
 mkKDSbpW1JcJKAAZtfFabQV0ZGI7TqWZlqo3AXsayy42gSw7v6g+1gGBw7SjWB+n
 pI/1Oy7K2n9v5746SuqfhYWkIf2AoXKZx7NWoRzDGazf/PJ7zSDG0r8ITgSTVaWD
 X++JFG2o/fpng6QQASI9c5gvT9cyqvFpKlyEjkkUfw+3nMc2lmsStQqjA6rWtVn9
 7IAK52MAkALuckgcBtHxE8bPGBRQdIx6RxR4jgkbaZVBXDtVSD8N2PbN3uacqza8
 ACWxeRJbyW2J468G8zRfklcoM2HtzT0dNPxERQanw7SKTA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ajsy6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 11:32:42 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-169846a19aaso720634c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 04:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792668762; x=1793273562;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dXEU4fNstySwei7nZv6T8mycxD11pRJ5qnWjwSzk+X8=;
 b=eey9XN8w0GhCp4fJ33tNOwvqNGumizk1YyZ1yu2RVm/PiXJytAwnPYMCwiVfKaPeeU
 YdkQqhB6L9mg+66g7VHj7xbbSCTCi/7XwZm2fh63sXR1P6Nyb7OheMnwklMY/cJK467i
 Z8JeUcXBOU58SBfR0pxcaCwMl+WBPPkVOP2H8cxgJJpqa8YeWIwusmJFN6WmjHb1CO1g
 lkX701uXTLka6gZpQyaAPDLsYTNiRtrHQ744MExtleNbRIag/H1SXilFGG1GWbTphSUy
 tZdLs9MTJBkixbX+Mg/lf44R9DCyaEWKNbI3pqEl4aQ+M4d1jYzgqwbvCcIJirG5LrpJ
 O6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792668762; x=1793273562;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dXEU4fNstySwei7nZv6T8mycxD11pRJ5qnWjwSzk+X8=;
 b=aXl7gSzJadJVl09VVUHo5X3KWhlpIX65hcOQBghnChhvXvNjqnDpQlEd9VWsBKeO9R
 yiWCv8zV866AIU5qyUqZhF/Ce4K36/pFFKKEk1fKsYwIeeldn2SO8dkhefWW1xpViX8+
 m+w1OgfuZW4tMWd91dFckf5WIgBvXPRyB4NkLwXa+f+6pd/Cf4KOeXTIlBkDdeYzc+6g
 ZGFRTR1JhcN36ufX49SVeuuG8nkoBWxDvAqHubhJ5aG/dJg+p7KH+Ac6aBvHu/yv1smf
 OGfGR06QFv/OA1EYVx9DgwzV4ZT74e1NpB28iItQO/ssaW6K2NPB1Yjl1tVnAUpwJdFj
 tmog==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYq12blTk1E59cm8JPyTy8Z0hBxLYkjIXdVIqKcyaMtL0/OFyxX2VoKrKe8M2tOg4IedEiQxXJHu0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKJStgMNct4XdpPWZ2387GJjNpY23ByqEl8lw1o4NnIqjgMVssh
 IDnZBqAP2XerjomefE6uRqnlJJJBVAyQIb22B0MlBkCdfMk2Lbk3fB4G8AGdZgKzMyj/QzrLwMs
 Y7HmjL8Nanojw0Ex7Q1Q0zJQ4jlXN5w3HmOhbRxLmjOQOSGR6jbiFdz+604nS724sPBkcMUo=
X-Gm-Gg: AYBFou1kKJxlf4ZgWe2VukOT4dhQxZLggn7CHP49+ce9YmY/j0+TTCDkTXdSF5fDd9j
 mljkFIhbon9r4oUhkNtXBoovvjm6ajV6Ox9aiAK231dnJsgFCmNI5wEWnrK+nMNHOeHp+fE17C4
 90hfY1UgP533VslOSTTIjxhKZ8xTmH3pOF/3TWxeuP8ITDDDEdnq6wsz7ONnawe/IkPTw/gT2HU
 uO5rz+w5OOGfNjxgQmi65au8JYsB3TtCkb45Rv9AxhqmS0e145ZK1AxEL82JD8fA+8qsW3WY2K9
 bJng4Y7qXaHIhWZBPn0KpsOD4XGxm9mpLsB6hsD9uZcarXO51xMnaRWgsCokW3Kbdnehf7j1JE7
 h/8cZqP801ge/i4ueEwU+1O45yg==
X-Received: by 2002:a05:7022:fa01:b0:141:5281:8a41 with SMTP id
 a92af1059eb24-190a4f06512mr7988800c88.9.1792668761589; 
 Thu, 22 Oct 2026 04:32:41 -0700 (PDT)
X-Received: by 2002:a05:7022:fa01:b0:141:5281:8a41 with SMTP id
 a92af1059eb24-190a4f06512mr7988744c88.9.1792668760893; 
 Thu, 22 Oct 2026 04:32:40 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-190e29381d9sm12143730c88.18.2026.10.22.04.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 04:32:40 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:02:26 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Message-ID: <20261022113226.tfuhxqrtfl3c4kcx@hu-mojha-hyd.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <ce3f58f7-f500-49f8-89cd-611d8e1ac6ac@oss.qualcomm.com>
 <20261021130735.h7t2c7txqdfohrs6@hu-mojha-hyd.qualcomm.com>
 <zqu4sweaftstbt26v2u3ajzv7snnqswuyrktm7t7k5gh4zi77e@d6t2fpsinvxc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zqu4sweaftstbt26v2u3ajzv7snnqswuyrktm7t7k5gh4zi77e@d6t2fpsinvxc>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0NSBTYWx0ZWRfX2+NArcpsIUmz
 d+KSGoVFjDAm5OVdMVfywAjaA6tN2v8Y52qraqBxlZwa3+zc4FBwDSDQ9QEDaoODJKcEo88sIJJ
 0zoU2t3vtivS0BXHE22tZW8yDLBCWigzlQLSAUtL+EHy8CPJr+Cn+keQb0wz+OkYDzlsFfrXPkj
 5r560yCbaFTOnnwNW7LLZzP3s78xF62juLv5I8quj/jZ7MJkeS90GzPODpfDcCY7xGIAmE58R+o
 bRCz/WrfpJ/aWG5e5DDV85Q9LgyIU9CMsCoAiATJaljObNOESYovAi2BVW+zdXJ5CQ3cL9YsZWD
 aqWWbXOyL/+Q3F9fN+3l5jNYRU2MpPfcBVHvUi+vvMetO1Vgm4ZoPBuoMVQPwwNVEi5UDXc+4G5
 RYYkg067r+oIoAUfSA0Pqmzl5PYPolxPkqw3F+4K7Onbs7qrjmyubrwS5RoY8uScSVBNViHwoL1
 PaNWm/UnAl7IiU43jCA==
X-Authority-Analysis: v=2.4 cv=H7FOUOYi c=1 sm=1 tr=0 ts=6ad9f45a cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=ZHN8ZsQmYYvh4dXIsskA:9 a=CjuIK1q_8ugA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: p_QUadkzejclyzmdnMS8oIE2S_MzMmUS
X-Proofpoint-GUID: p_QUadkzejclyzmdnMS8oIE2S_MzMmUS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0NSBTYWx0ZWRfX8+ZYEnV4Hw2Q
 FGeMEs76YDsRXjhETS8ztCKjNwqFO98ZSNMJD1CW3JYoNmgmUpeSnnDR+w1IOI+KFAYgdiaskSd
 rycwKBys9WMpctlOulSHrebcFngj0kA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220045
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

On Wed, Oct 21, 2026 at 04:19:59PM +0300, Dmitry Baryshkov wrote:
> On Wed, Oct 21, 2026 at 06:37:35PM +0530, Mukesh Ojha wrote:
> > On Wed, Oct 21, 2026 at 01:32:13PM +0200, Konrad Dybcio wrote:
> > > On 9/25/26 5:57 PM, Mukesh Ojha wrote:
> > > > In preparation to remove qcom_mdt_load() and qcom_pas_auth_and_reset()
> > > > public function, migrate every user to the new PAS context-aware API
> > > > qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset().
> > > > 
> > > > This series migrates every remaining caller of the deprecated APIs
> > > > (qcom_wcnss, adreno zap shader, iris, venus, IPA, ath12k) and then
> > > > removes qcom_mdt_load() and qcom_pas_auth_and_reset() entirely.
> > > > 
> > > > This series is based on top of although no dependency as such.
> > > >   firmware: qcom: pas: Make MDT buffer retention explicit
> > > 
> > > LLM has the following comments:
> > > 
> > >  1. Metadata buffer (ctx->ptr) is leaked, and overwritten on
> > > reload, because qcom_pas_metadata_release() is never called
> > > (patches 1-6)
> > >  2. devm_qcom_pas_context_alloc() is called from repeatable runtime
> > > paths, so contexts accumulate until unbind (patches 2, 3, 4, 6)
> > >  3. use_tzmem is never set, so the shmbridge prepare step never
> > > runs on SCM and the commit messages are inaccurate; TEE gets
> > > a real mem_phys/mem_size change
> > >  4. Not bisectable: patch 4 relies on the NULL mem_region
> > > handling that only arrives in patch 7
> > >  5. Patches 3 and 4 don't apply to this tree; iris
> > > iris_detect_firmware() still needs mem_virt after the load;
> > > the base of the series is not stated
> > >  6. Patch 7: NULL mem_region now means "map internally", which
> > > weakens the -EINVAL sanity check
> > >  7. Patch 6: redundant second ioremap_wc() on top of ath12k's
> > > persistent memremap()
> > >  8. Patch 6: ctx is set under one scm_auth_enabled check and
> > > used under another, which is fragile
> > >  9. Patch 2: the context now carries the full region size instead of
> > > the MDT size, which matters if use_tzmem gets enabled
> > > 10. Patch 3: stale qcom_mdt_load() comments remain in
> > > iris_firmware.c
> > > 11. Patch 8: no issues found
> > 
> > Thanks.  Will address them along with Sasiko's one.
> 
> Just to check. Did you verify your commits with the lockdep and atomic
> sleep debugging on?

For this series, I did not.

-- 
-Mukesh Ojha
