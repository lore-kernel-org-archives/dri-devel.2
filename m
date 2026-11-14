Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44744606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=SfwJAfg0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52DC710ED1E;
	Mon, 16 Nov 2026 08:59:56 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BDCC10E257
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 17:45:49 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c50ac25cdd4so153782166b.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 09:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bairaktaris.de; s=google; t=1794678347; x=1795283147;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cEiz3TWwHF+fIuW7i8DsJuBkmIDZsePDbm8l7cMfQMo=;
 b=SfwJAfg0YxAsbDltxbuw5AcwSqVGnuAkZZgyA9stMz1uFOczFZmuImj55MCzRtlP/L
 ue9bW62pet4FJvn3G1zSwABWs6elKtUtGc+5WifYGkuX77d3jSi3dsCf8Lnf7/V/yeBr
 ycKwM4Q8grFCqRQJ9xyVXJL3+VuDJ+fqK+jznFPA/4L5U8hrw2NXicZienU1UKx6v+gX
 SNzwi5shOuLmpJeMZuENKIYfcudBCKW9HdJ+1kmivKEXj9MDSANMY/uMAheYXMQdATeb
 TIwAiXYnUXoY46PGpOI3PHcJ2vRawQNUfiTsUhzjbnV5uH3wgbVsnbtm9j/Irx3voFU5
 yz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794678347; x=1795283147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cEiz3TWwHF+fIuW7i8DsJuBkmIDZsePDbm8l7cMfQMo=;
 b=ntS+Fc0LTuiZphI4FLxQi8RwjntyT9V2SvIadLasYmvkJisoX7ovrsr+jjHGdxqHkm
 +Rwbp3X62b/3RHxqs4Mow0vElFazeu8vZi7Z+lFAwskAy1vEJ1m07UsNiVMCZ3lG+Q+I
 KS0jV4FCpPcefy9T9GWDWzMMx0wcGtwlscL+9ptO1IduXJxXF0qfDoOTcHsYReIeHzcM
 RFAshrp73twWKqod7itcB4praimgZHkLteBxn+u9ngaw+Fml9WKfmBHhaKA7DUlfyTfh
 d6KL8mT+6YaNe3uVJFwGy6xltwJV+2XgQ/sWzwgGXJMkc0M632b32GTG9N8VtXT3MnHR
 SWpg==
X-Forwarded-Encrypted: i=1;
 AL+hErG83a834xsNRgCcPTzK/8aUrlaKk8baF+VmgodsGkIRN4Je8wGSnKfaLM6IhECboFWuifBz1Xb17HA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9U2xlArXdn9OJWPOhEqhe+Xaq8CtVfYpSn7ui0pCCWOU7NQ5LP
 xyM2s7AUttRF/qblPlhpQxZrEPqz/KcrF+fOWZPG6od+lDXirHU3BfvIII+/WRGDZA==
X-Gm-Gg: AYBFou28x1Oc2docIp3LM4LF1qtTboty96m487gJIIQca37YN6OBcsEsITy0Ep63onk
 QhBk4Jc4znUT9WpL3wIE5pmneIN7f53J4VmD3amm30wJ3N9o7f7Srsz/tMjO6Q1y8s/jR/M+pIj
 zhgYLb4kJj1sMybKu7nufIuAcq3xNumOz1QDkrY+4NWJ9J9sXAw6LSixZSKBvk20yZqJIJQWgW5
 vOh780FbhEwmfnXzquu18MkvM56TRUO8RJdzgjUbq9/WnYMUSMGD0AiVKbny8J9e5pn7bxc0kEC
 lpeFnOC30v3kG6E4c6wLLX2/BZV+8gOO4Sm5noYTXw3vgfBo/stPaQAy2KNNNe4A/+zex6SloW2
 BeL1zLY4z9h3MDyexYmpka6PgzvEuzJeVteOBlNuAIE8ZWCLgMR52qQvicLZbYA7dMeXureDMec
 jxpAo4NhyWQft2g6dyH/jovUalmZzENe4kRS0MyZEaKGEb+VVh7mRnnXr1h910ORCcAJu1Z0j9F
 KT90CB0V2/T7IPX5smS3FDshCVJu/jbXFEfWG/ClCrsjTo16ZfvP205jx9uAcxwUEuF1REsk4+r
 xQzDOqjg4cyBUydeDpik3gXk0iumfHpSIu4Aewa09dsjkWQi6O4Myf83aa6tuByuPPCHEdcXA1K
 sBPktJWuK+LdevZk/fr9p3fU+MJCXr4kzbuJjt/16oSUo55ZAsbSyoRLQY8Czggoy61jg6DNoVi
 uRhpz4hrvObfDeS9ZzhHjmR4Ht9Rjdef+LeYrTRWloXOZLDBEs66r+1d7ZtwLu15UMtTMdTkKRr
 V3WDRpitIBy6M8O10bFKCptinlzBlTBEF/+O+TlSRTM5deq0aaCBkalFkMHBH/XF0Xs8Hwy/+02
 +0c=
X-Received: by 2002:a17:907:3e10:b0:c40:231:6eab with SMTP id
 a640c23a62f3a-c5096370c31mr488914366b.16.1794678347384; 
 Sat, 14 Nov 2026 09:45:47 -0800 (PST)
Received: from Desktop.fritz.box ([185.181.130.189])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7c236124esm2474985a12.6.2026.11.14.09.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 09:45:46 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Keep objects of queued VM_BIND unmaps busy
Date: Sat, 14 Nov 2026 18:45:44 +0100
Message-ID: <20261114174544.769803-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CACSVV01-U9jEOfKsO8fgGtG_xQqjOF4TAKycJnqp4E-eDqsC2g@mail.gmail.com>
References: <20261111080619.244138-1-julius@bairaktaris.de>
 <CACSVV01-U9jEOfKsO8fgGtG_xQqjOF4TAKycJnqp4E-eDqsC2g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 08:58:46 +0000
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 12:57:27PM -0800, Rob Clark wrote:
> Nice catch.. I don't really love that it means we can evict mapped
> buffers but not ones pending unmap.  But so far I don't really see any
> better option.

Agreed, I didn't find a better one either.

> (Small note, a dma_fence should fire in a finite amount of time, or
> TDR should kick in on the signaling side.  That ofc doesn't change the
> issue here.)

Right, thanks.

Julius
