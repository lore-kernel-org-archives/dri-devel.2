Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4C4606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256 header.s=a2048 header.b=QcZxjGvD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53A23112C53;
	Fri,  6 Nov 2026 09:18:54 +0000 (UTC)
Received: from sonic307-33.consmr.mail.ir2.yahoo.com
 (sonic307-33.consmr.mail.ir2.yahoo.com [87.248.110.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC9FF11241E
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1793913483; bh=1EYScnE0lKxRYwubxdcMCuFPTLuQa63CnwgA759Oz9I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=QcZxjGvDR+WY1NQk4F3WttqXxioF/Sx6Vb8TYW1/c6EfePV3JyK3xpDkaSSDmOQrACxWhQSowCY2mBsZMrPDJEqTf91KQ66nph2wU8FDnO6gd5552cCFONnVj6W5ma21TfpEDhgX5t9HYVZ66ecJqW4eoUxlfuN+f5zjN5CNDn6pHRyKdWWCRj8uqik2zOe+ToCFrc9IFopz06kNY1giKg6JUXq5pxLcQ2neSJspgyPVSOomV6AGAYJ6a4O4dugyJjr5vU3ICzgI79ZSfqLH128ytg1IvpwlSdKZ4Rkn5sr866FQgJXuT+CjSN942U5uxyTJaazm5blHZUI0Yijvvg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1793913483; bh=HGz3t98R8qu0W5W40JKWQBJFVT90DzMlIuyBxJI7Tgo=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=Qm0T81F3P4GmVfKnhb1dVBR+c9yi1YMvTxeDsAzePEaI6DzwlHvxWTvhNgFwmuPL7wrQVdcX/3leDaYPFot27Fj1VvxtrKntgV1AFG8MOCQAZ+Wj8Hf7/7HvBN4DMUCLUINKVApfC1Bv9P1Rz6C5cGyu2ukjI+FDR1A/zwNKIFKm6ao0zjlMnTWXXUQ2AFZEr+uvLWlnVapRNaMwpIrrPw1f+f5y8nwqr9edEuEJDxF2pgKRE8aCrqIV6+QLUGLDPMaRrI+guH3AzIKTAXP0kWYMws367h7jaypuNOUCit4TOHrGXtwscJ0bFf4PsEcLFaFKkLfCfaCnjRUhgsWIzw==
X-YMail-OSG: XzotGn4VM1md098.G2.j1U3e6PqJ7o0P2ztu27JlCkHOlDg5B1l50hXxcQ9Vm7g
 8lKSnE6peTFdRuvJPswPZDu257kREwavE37MsyFRbR5Qwfxvh1Q8BDoIs_n3.N8CvnbEiryJyyvz
 DochkbfZo549S2hFp3zfccwEr0Vi3vglTYugXgC.7hnnVo4aoBvmn7nZcJk1uBPkCs8SX1qKqeV_
 jDkb4I0zzMVyER3ixthI32zVIRSw7Xz.7uy9zAggzCrTicOtpPv6xkLUBq_RqkM9Rzyz4YT2qr.F
 YQ5uJyMpaJvVEYcBcbR8FYW.DqbdWniizrH_LTE40SZPMzTCxsshQhZie3Q4H9.zOyLp9_dI_fmU
 eYyfWwMLHY4VmOLE5AkgNyWrg0O0oPtW9kPcBjFKSmuCxvVhAJNYxOAEZMVyBjzldvBIYzYvbgEy
 aTUrIhH6uexLNgBdgFkYYmcgWZ160WofW3wh0rkV2UKdr3c9zComdXGLua_Lx9sWMzqzVONFPkMi
 I0jtzoul1Ikbwy3Oql6na0rvPz_jnNPoRNbvgftX3eF1LHvp5tZFEg9c323tKWZBBUZu9KGXa3Mv
 QKRPNGBa.mY5t2ivUWtdPEwnPNY9nbu8S8up.H73OSYvY6.c1iXgeUniItay9k6ONozmfupCAkll
 tkMCQexEbe2fOPivFAIyyMOGH2ajmcDjgls5o_0nURM1M1x._RdmQTTHDPnLddy_AM27bA.edVp2
 v3aC6iII8ph0wrOvYYWAZJtuVCBMvqiYPcc1rrZp1mq8TBQUou_rp.5R5FQTUNthJ8foT4OL3.Zc
 aTHtUU6de.Xm0mpoOxebT9RE.u4jYpcaEGB_iQBkyeAR_smN_7znGqiQ74O0YxN4Gfn7TMt37pId
 4u1Vhu12zcyrRD8pM9dF.UHQU2uMyvmLAlGwiRbtzOsqSIJmpiIUWq5hKytHpTNwqBfZQD807Pgg
 215Vy5g73ttwctWRNMEtMNe9oaGqBVz0TUbjgu4kWEuQUXNdUEfeONpgL8_rfJ.zcibrGK45kmbz
 KdJQJ9wc0WmLxa2awb6fzGy9Yc7NIAdWh6BH4gsBvakZASWmUG1Atxwq0uPzexElb_Exu140SeTO
 C7LtPGRUy6QDM1vZTyz95SYd1nD4qpxEBqHDGLE4y92bNeZxIJhL00NBxoQl5L.TPmPh1UYxkE1M
 R3R7N38H6G4_Ehqqy0sRTG0qqXUEhB7AFhlVbr3MsXfBujqvcMO4Dc.F_3LY5ILOXGkDJK6SxNdy
 Oa7UA6f1vPHWShOqvBPwHuPLk5sfBoe_GvGpgUVFbVyRxg2tgqPJe7rAbXHsRoVqSoXTBXa0nf.j
 RBai1l3ubBNomKQajsniDh12BPIDmPrW8j67Yx_lhkjUDvp6ME6DlI4Z1YidpffccTFldUnDS3lv
 yhILxdlujApBlvU8_jwIDr.2tTziorb6XpwDfyFDGnWm984ThzCi61c9q6Uemp_6SPvqN5_0SuDO
 GRqn9Zt.pzbFOpiwwSz6hz4eByOPgjqwgTdDZ6rPvAsPcDYfjmDmm0neEZViqZ54_PDP8SJA.7a1
 vs3.6QmCMabVk6uZ8gTgcpstRCoNEfhhV82FWBdOgdy9XSmRTyyCc9xuJLIOSetZmt0b0SYZ6jcZ
 BIGjOBzVtkgE706hgSeIrKQIekKMtigbr7_I_cGlu1KGYDtfCFp1C8RktIpOsjMKnmX3IImkWIhc
 wjE1XATIxj4AjBDFyl_A.FXlR1Miqcy5RjiIhpxqXU1ZZVcSlSQrU9Z1Qu0KIjH8dI7NPl6Zfng7
 Xhio0xaFzPlqImhURxAWBIPMEq5N4B02ooAgQNoPu8jlJoChiex1GTtsr5SXqTbqeyjdqKx6LxzP
 AJq5aeuznpM51AhSBxcUY3qv6YyfFZx77JBXyIFP5XY766OpzZtaXTNeDNe9ufWr13j6d1ujCpLS
 sgHxYGcH1pQ_kt66aC9eRy.Qrew1gQqSLBMpR7JIF0UIc0Z9B3P.y8cxLoGwZZjxZ8nKnKtox1Tm
 vICI8tdwNhus0TBK5tMx9hwXbiWLHG6nWHeMnq1y5mBRiwUuR88aikShE6HpnnCG7HCBMQsx7QGt
 FFQ5AmxrxE13SGv46aTBzlTU2oj2lEGPcTb38r8cuNB7N.4I0ffCThVOofpfrOY7v2_4niTGGLYb
 uqlg7TnwgNxzGhevVWDSB55F9ekH35nWC9YIv7lrZHhB4OPa1D1yp.93EbvrN2RCYyCmNItzRZ8M
 UCZ1ZtnRkKX7VND3tmhpP1P6J6L12qXtDyoynAG_j_BDb_YzBIAFyKgkE9paul3IEOLoyIZhY6a3
 UHkGcUaGN3o98xaUJDm7iuMyrElO1rcKGacZR1dE1_7EJ0ZImRulQ6g--
X-Sonic-MF: <jonathan.kuehn@aol.com>
X-Sonic-ID: 10b87929-41d6-46f4-8293-806fee5b5c87
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.ir2.yahoo.com with HTTP; Thu, 5 Nov 2026 21:18:03 +0000
Received: by hermes--production-ir2-5dd9bf4598-p4sz7 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 260db3b5d3f83d9c49ca8d388e9ce5f2; 
 Thu, 05 Nov 2026 21:16:02 +0000 (UTC)
From: Jonathan Kuehn <jonathan.kuehn@aol.com>
To: sashiko-bot@kernel.org
Cc: dri-devel@lists.freedesktop.org, jonathan.kuehn@aol.com,
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH] GPU: drm: nouveau: Prevent kernel oops on missing
 firmware binary
Date: Thu,  5 Nov 2026 22:15:55 +0100
Message-ID: <20261105211555.36218-1-jonathan.kuehn@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-200128@kernel.org>
References: <sashiko-outbox-200128@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>[Severity: Medium]
>Can a NULL gr pointer still reach nvkm_gr_units() here?
No, the oops was occuring on current debian kernel and I tested my patch
there as well.
For patching I used the drm-kernel-tree, but I forgot to check, 
if the check was performed previously in the call-trace.
Sorry.
