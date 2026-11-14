Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207AB606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bMsx4Hip
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B3C10E0EC;
	Sat, 14 Nov 2026 18:51:10 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A610910E0EC
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:51:04 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-36fc0a3fe93so3951225eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 10:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794682264; x=1795287064; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ti+Jb+6rot6D0fGqe0TLD4jEkN6i8C21i0D0JqlvkBM=;
 b=bMsx4HipbJBU1Gk0zlKK0BtlW7NNGDx7+I/NjZzO84MLOPXMlYHi1JyyIts6aUE413
 W2WjPvtKL/zmGMOMvU7Yt4H8s73Dre8DzXWoSptaLxjeA2j3A3GB+QlXZn7iakC8K7Oi
 semUfmnIgax/yNV7n17Ym9TvrRvIsdPS1MSSALZYdJiJ9EAGopuuOOnckJfsl7PMB0NX
 41NT0B63auo9ImM7NvM5papBWhSds+rnp6b/clMCuIxvliS1cI/MfPda8ArQShmdVu8G
 KlllN8sEeT1Nj7KUSHv4KfX7IeQFYxrqbA2EP42y8wpxs/jaGSxfnbNBvreVfT16yNP7
 vHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794682264; x=1795287064;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ti+Jb+6rot6D0fGqe0TLD4jEkN6i8C21i0D0JqlvkBM=;
 b=2R8dX2gRNjYlx5Mv6xIIz29Cd3TUUHd71sfAWz5IhD34W9+KGSSF37iq84+3/Q7n/P
 mI1CqU7LTA2FtkpWlFzLsQ4NHH6lgusPprRxTGhSKE5N/98DodZGFz7Vg9F69iXBt5Np
 Rids0M7I/OH3eiuBv7P48dW8d41wuKzQCnRmqR+k3mbjYUey+SPpdEvYEQQGf6BxMwG4
 +zTYvuJ6UPbbpxjNb6GyiUtsHF7zdk12nt4wc93jPkds+zFCyUPhuxU2901EQ68O58ED
 20rUOYnz9R453MnxiPRhrDt9VQw1WwW2W3+L9QmKmiLC0qtwGsrF27SE2uVIM59pbIyk
 wwLA==
X-Forwarded-Encrypted: i=1;
 AL+hErGQaTKItNVOyNe00MPS5/U/NeHeKoFanLBTYUPbzoE4eEVCNBUGx4EkJ/AosZ4B5KPjWuBueqvqMSk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+YMGNg4+qv2M2RLTFuxC9z6T9DfwzfOM3f3gaxUSLdTm1dKATI
 lgBmSvDDhhU941y29+BoaAVE1m9qb7iShsDzY2l1gcdQ3hTJWn/czokO
X-Gm-Gg: AYBFou0qQb8PdeN8CTNF3+V6tyUY3Hz+4/ip7ugjiAF3D+KGlLKlHjdnCiAlD6Fmw5v
 t9PPYE9FEIypYJhtWY/tuE9NAtLLPxiFDF4JHGVUE6QFiNfTk9UM8supSRbeVFEi4xIKPsB2F6p
 fq/ELx8u6PTcZ24MlI5NAA2AxxOUOz7WShUoyYtnLMWbcgaBvdgEDLm/VsJmfTYtLenHsvcYBOR
 ZjZ/g2LH61KmSRakFwJ37JXwICF8Rsw//j7WCJxBmaFfPBK6IWEsBsM5a/hLOmAxwMcLZMUzJ9U
 lwowO6hTtJSvdAStVbfTya+3ZN/bnZbu5dbSHZlTxmfOjyWMNG8Y+JM7JIiS8gajXvnHLpkk/O1
 zyTLdw66VbB7pZDuji0G1TmMhJxdkaHXOskAO2fjSIBtl1MTJosphirvC3YwhkNhLaPTk61GXTk
 FA6A42h1rA1zEdGM9Z+Tq9aJY6UaGmXIJnu66qQTBsooPp3meDMJhYaDQeoOvY96xJI4dSeXjkI
 GJCvCH9rpnBhqLJ1//RJs+yO00h23lOAIypEwKdYVWFyYGZhM2Vbo5oq+W/Kh+DdSKF9a7JRbYm
 0VJVAlGcdpAHgFfw9iEA5imRw7H5/Ype5H4vsAg62NJXVRtopnjG0uoA0Odnj4fyxdyWsl/wSPn
 Uj6cJIHU=
X-Received: by 2002:a05:7300:8b85:b0:36a:1f8:a56e with SMTP id
 5a478bee46e88-37966a5848emr9057429eec.23.1794682263819; 
 Sat, 14 Nov 2026 10:51:03 -0800 (PST)
Received: from ?IPV6:2600:8800:1aa1:b100:2831:c6dd:8b01:b6b1?
 ([2600:8800:1aa1:b100:2831:c6dd:8b01:b6b1])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d269asm20079398eec.23.2026.11.14.10.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Nov 2026 10:51:03 -0800 (PST)
Message-ID: <da130728-86f4-43f5-a8db-796562c3d0f0@gmail.com>
Date: Sat, 14 Nov 2026 11:51:02 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/vkms: support more formats and fix RGB565
 regression
From: Sidharth Saha <ssaha2000@gmail.com>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
 <f3707b72-07f2-41ae-aefa-c46ef84de3e3@gmail.com>
Content-Language: en-US
In-Reply-To: <f3707b72-07f2-41ae-aefa-c46ef84de3e3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/2026 5:18 PM, Sidharth Saha wrote:
> Tested-by: Sidharth Saha ssaha2000@gmail.com

Sorry, I got the tag format wrong above (and in my reply to 1/5).
Corrected:

Tested-by: Sidharth Saha <ssaha2000@gmail.com>

