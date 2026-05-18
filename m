Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF76ACD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 09:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EFB710E4CB;
	Mon, 18 May 2026 09:10:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H4noJqax";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E02F10E371
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:10:28 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-67e24b8ef55so3579765a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 02:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779095426; x=1779700226; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NK6QaM0AvluQNq8GVPqTX/wBbD7FgigoEBmBlLT11LA=;
 b=H4noJqaxypgw7j7WVa+ou5g88gL2I2epp6YdM7zYPNCoD97HQDjf6LV1Ct9ykp7Uzg
 xqETRC6XQN1e3tW5tdg6DTBwAssa0bvSEgQ37ez1pxRK8LAFQXJnfm+SYdZ8Ue8Oxx3s
 1GrDLihpKT+NH1Esti0KloI9xAPI/YObiLyX05E1MVfz5siGiLO8MG1UGx3Y4go1G+Hu
 yXqktWyPgiuVqnadvHMZbrlgmyvpM4162HNCGMUeiDJDog7U/ufvb9cRd+iTb9o91gg5
 k8629sdHOVRW4mPQDDTqGNYbrfR0s5PgHQq3gJ2NbMjModS4qN/7qEbBBmTKSlKsdX2M
 DPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779095426; x=1779700226;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NK6QaM0AvluQNq8GVPqTX/wBbD7FgigoEBmBlLT11LA=;
 b=hasO8tq8YJCxFHsAMW1EpC7RkEuaPVxuJhO3EZ9KdFn17sxIZBGoaAGBlQFpIyekaz
 GvSTPfUOZUlCgIXdHI+IWbSJkgwARU8Qg1FcpotSxUqdPnmFnS6Mg+VINjrZhw8q2xVJ
 f5Cidbo0XyP6PIm1XaQoWGX9Zo8BnEwB7lxh9L7sCBFrS30LE2Zb8IBotJi8M/AxTMRv
 dPyc41QnWYeIdeCAypa7YT03T3D0ACNuJwL2mqYhUQfkGgABIWejvbZtIF03USpohAj4
 6V9yj7kxzfIZat4JBp0KhyjF9sNy5pwKqGUIePHn5WNBlTSsOlr7Qwt9XlpNMVCwmbiW
 3jQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ84w1K98SxasPDqsr877KboYQhWGLdcJdwn8wtnVHQiGzpxNnJ1ltxJkPp4m2RmnuaTYqCxBplb6i0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyB8mJkrGmLkobboZ4/7qOFjw2ArsEHHVNZyXp+sutZeMu28dHb
 2iKzcAn/UXPfr5+TMUis2orm3Mu+K5iiT2hR2Vu3n4hJlBaj/fmw5P2q
X-Gm-Gg: Acq92OE9O6UBYAtuHDyeFQtLeE3iCgkf469fsZkUpRaNKyeezhQyc/XH1PIHZJgFBal
 UwfiPoWrfcNxTKCr+5ldcCaKDEF0HjqHaCiZ36OT2dZ/p+LQOiguONdVhzyhHgjAWx4qOAJwjGJ
 8NgfwHp5RYHnVaEPWa73IHOFHcSnGh41ntXHvvwUcdVg/E76eNHFwLA+P8I2r4wU3yCs3Gsucxq
 vPVfgup4cxthFRceLwyLJfao45yxivMY/DoHVI0CHww4DJGNNwXu0cP9HaDE8LPBpN4cU4Kwgc4
 LYC2EWy9nQeVBEh9z8gc+P+ROpLUAnkCokkj7YlbJDMFHv23pykmxptmTTdWuNn2zx4mQo7AL3w
 8OEdzyKPdoybO8Q8XcuEcKiXXGxrj2dLXKLPqKGsk4F1oC5oD6KTSSp8FGAYPpwKt19rL2VUvHc
 T0OtrHrsWGCSZJKz8HaVwokEGn/go/wMyEBkQbPfyIHx0g4xr3zGxrN26q1KFsor5lclO7SKsqW
 OtLghvNdka6/eBMV+CbpaG5VAcd0Csi8vuuhfacM06nLSmQpTeJjz3UooVb460qp1pd0Q==
X-Received: by 2002:a05:6402:4150:b0:67e:153e:51cb with SMTP id
 4fb4d7f45d1cf-683bcd9e33amr6611396a12.16.1779095426574; 
 Mon, 18 May 2026 02:10:26 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:6e9b]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68310b4069dsm4929655a12.1.2026.05.18.02.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 02:10:25 -0700 (PDT)
Message-ID: <d14967a9-979d-428e-8190-6a756da1c130@gmail.com>
Date: Mon, 18 May 2026 10:10:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v3 03/10] block: move bvec init into __bio_clone
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <43a91f54d61d3329316e40c69ace781b4d35fe0b.1777475843.git.asml.silence@gmail.com>
 <20260513081238.GC5477@lst.de>
Content-Language: en-US
In-Reply-To: <20260513081238.GC5477@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/13/26 09:12, Christoph Hellwig wrote:
> On Wed, Apr 29, 2026 at 04:25:49PM +0100, Pavel Begunkov wrote:
>> To quote Cristoph: "Historically __bio_clone itself does not clone the

Sorry for late replies

> It's Christoph.

Oops, typo, sorry for that

-- 
Pavel Begunkov

