Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D876D606A8B8
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fl7Kmboe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF55112025;
	Thu, 12 Nov 2026 11:40:55 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F68112025
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 11:40:48 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-37071c0f42aso6994895eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 03:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794483648; x=1795088448; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YeWP7Ew8IEw8W3Drb+1wADQhHaKMJ5pzT2VKjpcBucw=;
 b=fl7Kmboek/SYn7BHReIpHyhRMG6gwnUdbKKVnovkAXQudjFUh3qs9YyaUnrNtE3VQA
 enJJWBmRn3xV5MbsFSegYjZHmjPLD0Rl1cirVzz8JfG8dzq5v6FjOdhiUAyEE0/vI5Qu
 cAaw15bwk67LbipnSbkFpn3/z6HtTIU0yg8BhSXOIFeacJu4rxC45EfTVYuIQsdas7Yr
 LBaaH4JTAy17qiIfwuWRjjgfaFNeRC02+L6lAIa+VRNrRdED5DB9/LSKBPb+Ygi8gkyF
 ibEx9Fb9XloqmQrvsXpj9EB+P8OOV4dW9wwdaNxZcn6ZDqtVWUFAEj5JJxO2u0HKFe4k
 knrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794483648; x=1795088448;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YeWP7Ew8IEw8W3Drb+1wADQhHaKMJ5pzT2VKjpcBucw=;
 b=t5Xq+6Iclvor4eT1irwAm8mQs4cnx/3/eGFu+Qe7drAxvpF13dF5H8W28LSlFVfdUg
 U79IJKKLjnlpXPYe9d7MjCZzuujrkNc2woM58wmnsUZJdx3CnR2PAfc3pla1Wzoy70wY
 fmYe3Oq3X6qKnDQKxaz6/KqkmlwjBjXsIqQPBCXrYMt1BZyMiZfHRuFIY8tewuQ5B4Ss
 3XXz0wqyygSt0lFklgYW6KSlRrXWEIEzoM29nuP+WjFAI7UubRNe4eK/lsypDFPFpaIx
 FvigUwcJMv96fCndxCtX1OlcWNPlDwgDWA4qp0l3KkFcwVgOJFwkaCEnzKUSLF/xza2Q
 PMBg==
X-Forwarded-Encrypted: i=1;
 AL+hErEjUwQHAaP8LrymABzTTOBwFjEERHUIjfnU+ANzO+mPJNs1yHv8N4Ixwi2A5GerPCixC5vNvonqI2s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Lt4ba6SBuHorlu7MQ2gkryTgR0N+DD7LPelB+7hdnyHt2f0nq
 55rfFQoDbIjAp2gzdv4S3X4QD5hBFlPIvj/XERTg2aA5PnrVBwMzZdTs
X-Gm-Gg: AYBFou3HlTYOGwRvqBE3qfwZu9kQbaKNU0dJC82gfdS1XfaWwpP7Dv96a082NyjSR05
 DruQbJMHgJYl9yP6NC4qEqLw9x1+lCQbuCq6yQSDW0ptZbK1BFh0vu5GGkXCV47KqDAKP726tx6
 wesV6hZwDOkwHMCJXnfQgEGTjBh/yiCWShV/KqtkgazPmUQZnTvkJfJbzHyCxDtYGZIqntn2g9C
 Q3gJ3bI92v+E8ohslhCzd0N6A2xP6Ekcj67k/YscxRF+PhxSfpQFfTXEyH5WLpNFdWkzjKXXWDM
 ptLAKY0DZObioyGMTum0ualqZmuR8FyTTDj0djfe8M+5WgtEtBW3WNs+xwRhmrUjUNNCYLqhlI3
 RHFEzvbtanYnk3XkqgkcaJCRmbgtNlCKqY7jZoGJkSb8pCQExz4FHW1EKQWyVUKStOyJkyQEM6M
 1QCfC6ElDKAOUxIqO5s7Uy7q8JumlSp6uwqeiSxcZF7Cxm5Fgo+GgR4ujxszLKZCcfrBxO4HGHL
 Kdh7R/p7hjfe/GRC2K9Gd7YMOyLkg3C4O5hrlLRCuiG5dq70imeOnIFyG8dY8UtVKMqiqXCXruI
 Jgy3otqGSs0Keb6Zdn3xzq/TxwZpD8rXB1zxyPQhm1Y=
X-Received: by 2002:a05:7300:2d2b:b0:36d:2704:6adf with SMTP id
 5a478bee46e88-3768579df8bmr7841678eec.11.1794483647847; 
 Thu, 12 Nov 2026 03:40:47 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([180.67.33.100])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3752060dc0csm29448853eec.14.2026.11.12.03.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 03:40:47 -0800 (PST)
From: Joonhoe Kim <26rote@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Val Packett <val@packett.cool>, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
 sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, yongxing.mou@oss.qualcomm.com,
 Xilin Wu <sophon@radxa.com>
Subject: Re: drm/msm/dp: hold one runtime PM reference per plugged state
Date: Thu, 12 Nov 2026 20:40:46 +0900
Message-ID: <20261112114046.396-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <2ndbj5fk7tnmexirfulh25kwx6pjzsmp7vjczbhqdxxuw3fm5u@qx5qumdw6ng3>
References: <20260929130627.959-1-26rote@gmail.com>
 <018c6fae-49d3-4f89-8212-8c6b64a2829c@packett.cool>
 <2ndbj5fk7tnmexirfulh25kwx6pjzsmp7vjczbhqdxxuw3fm5u@qx5qumdw6ng3>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On Wed, 11 Nov 2026 19:13:45 +0200, Dmitry Baryshkov wrote:
> I'll fix that while applying

Thanks. Please take v3 [1] instead of this one, which you also
reviewed yesterday. It replaces this patch and depends on patch 6/9 of
the IRQ_HPD series v8 [2], which removes the plug handler part.

[1] https://lore.kernel.org/all/20261024051952.2006-1-26rote@gmail.com/
[2] https://lore.kernel.org/all/20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com/

Thanks,
Joonhoe Kim
