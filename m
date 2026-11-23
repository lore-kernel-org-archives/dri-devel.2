Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA15606A327
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p8Zlm0pO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE77B10E759;
	Mon, 23 Nov 2026 13:43:21 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC0110E759
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:43:15 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c4cb6834eaaso555755966b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 05:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795441393; x=1796046193; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kqCL8yR438jqEfqX8sdAOmG8GdM6o1iX2qDOd73H3eE=;
 b=p8Zlm0pOvNpo0SQs6vDKlXTGYar6Wu8bAN5PSOu2s03RL7MwhmPdKVDg5+8NLbcKRz
 GZvFebrJgDLPx+AsSXiWlWGjmzz6p7y4SPIzVHf0KI93ZHLsMAtakGafcTIA8SevQtlU
 byz7lKEqetg1idxBCrKP5dm+paNq0ilyT33TLY5BG0nUFOu51hpbXY8nVd4ff9sSvIZz
 lFaVoCbVTQVFbpb9k+yg5fPCukcb7XBhCkIJmWpCZMBrFMYbWAzlLWH38T3iszrdf1jw
 U24/J5dmk7cC1hykt5Fmxyb6L3MHfMT1mH4168YKj40ptvv6jR7zJcDgcaMuOINAlERY
 5apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795441393; x=1796046193;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kqCL8yR438jqEfqX8sdAOmG8GdM6o1iX2qDOd73H3eE=;
 b=ZYLgwPQBK6p31HtBJ3IzPK0PuGJhOGEAO8NCY/yKECJGlz+QUBvbr/HIfAoqFmiucN
 HE5nWbUFt/MSjKPtYpPtpoXetuiSh9hj5M2XC5/iscdmPOs8EBDWDZ2H6TPkyIjNbMcr
 JyxKo39jxFWkkksPOyGk4YFjXLLZ37qN29XlrlXZbx3wl6RbOxjICjl9JVgISVytKRGd
 D6EV5RSPNzbt48dcdeW42/by54JUyP+PoBhsFvJNefVs9eHP2KW8Yrah5m++UwB5pdoe
 sE1Ar1lmX5y+Sf6R+NXDBGM5Fv+DP4mgQ9b5e7MbBedW9y0b4cpF/ge9HdPzwCQv+iRa
 rgpw==
X-Forwarded-Encrypted: i=1;
 AL+hErHBJiiq/jjmrc71EDg0Or7om8zQ9kpwXD4u61sw5npBYSqpX7XY6wUkdTuHQMFG8oGN6HxtWXFO9Yw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9mGNs+mfsjB87YwdpG9aQ9OmIXkmVYxCAd61j0JHaYSOQg7DE4
 1xn1lzzqZSMzptY72vpZPsiUP3qWfIl5tmgUtBNCFLSExONfVJNTAcQ8
X-Gm-Gg: AZFdTZd4cIqBtJCVZbS/82ugk/5esbuPvtD51OFo4+8O9zYpyYnjbxUN0QhnVM9S1US
 0yWtqaOO9ilJuE7udojM7DHYmlk55rQFvq1USQUTvvUO4OSs7+4U/tCrCe2MjPjCiuDwplKVOXW
 0/RRBk6rzDsgBKoFEW9wW2doUJNFv8uBMInwBqfRPn+VXRWQ94NCKTyOBbXLvdVWozfg5PDiKE1
 w87bXBZtGR+rYaIm/zHYMVmdQywPZYxABqto+vHufWS0lDDt+v1HUipHzPIKkMwZtSuQK5HmjBT
 8dUImtpfHbtLxw6VJasiq6eKwcZCGUr0DHCKdq4IDWEyq0YjULXgtbZ5uzUBL7niXZsnZ1DU2Pv
 yLr9kgLxJSm9KmsUUUXj2vezip8wuQeB4+IVy0Icq50Tft3oYBn8ZQqBTVHEqXOEAS7sYXbVkzw
 HlGu+6yOgQaqHT1q6v28lICbol1EYwb9JIbK4ycDEKxqjS8GrQrHIJq9uS+oVJ2nNWMzxgem3jd
 adEjls8yf558s4bozrQTrs86shYKNwf/lODItwsFdZSXSByeaBwfDoYrY2h6A3RCHYiQZcELNJK
 wUcrWwpDTpAaMzcZ6NIu+B63Gj3/E7Wr28asGeleknZMkDGIkTWQ2BCp4MaXvJ60jPUMN731Z8u
 93v3B/ThLB5GJpCJge7w2Sj8gU7ruPKl8Dj/zNfZBbuwA4jeml6AteqhkkmGXIjn1mGTwwxRRy6
 ElOUQ=
X-Received: by 2002:a17:907:2d13:b0:c50:ca93:19a0 with SMTP id
 a640c23a62f3a-c513aab9bcemr968102666b.40.1795441393323; 
 Mon, 23 Nov 2026 05:43:13 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513aeca720sm409336466b.53.2026.11.23.05.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 05:43:12 -0800 (PST)
Message-ID: <664a18cc-24d8-4140-9c3a-d522945cd2cb@gmail.com>
Date: Mon, 23 Nov 2026 13:42:49 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: fix leak of ctx and dmabuf reference in
 dma_buf_io_ctx_create() WARN path
To: Falconet3 <Falconet3@proton.me>,
 "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <htm5h9oaY-vk0g9JVYJmz5XCaKe_nPoWkUJYJqDulyNvv_sAWfzSMp0T6GWt5okc8R4SyvXXpJQ3VGhetKnjEa2KGem5uCYdxpmdzUFf6XA=@proton.me>
 <tRqxbL7txMRAzNLKylzBLQURNLpU-D0Xx5CrngGwLoYrK7V7kREharagUfgQLGIfiYFyTALR0BwL93AL_PWmFXq_MoZPhvPfUojBsyCnilI=@proton.me>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <tRqxbL7txMRAzNLKylzBLQURNLpU-D0Xx5CrngGwLoYrK7V7kREharagUfgQLGIfiYFyTALR0BwL93AL_PWmFXq_MoZPhvPfUojBsyCnilI=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/22/26 10:49, Falconet3 wrote:
> Withdrawing this patch. Apologies for the noise.
> 
> The WARN_ON_ONCE() path in dma_buf_io_ctx_create() is not reachable with
> in-tree code: the only in-tree implementation, nvme_init_io_ctx_locked(),
> installs all of dev_ops (map/unmap/release) before it returns 0.

Right, it's a warning for the same exact reason, and cleanup considerations
for it are different as well.

> And on the only path where it could ever fire — an importer violating the
> contract — freeing ctx directly is not safe: init_dma_buf_io_ctx() has
> already attached ctx to the dmabuf and linked it into the importer's
> tracking, so kfree() + dma_buf_put() leaves dangling pointers and turns an
> unreachable leak into a potential use-after-free. Since dev_ops->release
> may itself be one of the missing callbacks, the core has no safe generic
> cleanup on that path.
-- 
Pavel Begunkov

