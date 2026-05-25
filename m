Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B19CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C01CD10E5BC;
	Mon, 25 May 2026 08:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="bV0z8hXP";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 392ED10E601
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:51:30 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-132d1b2519eso2742450c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1779699089; x=1780303889; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eF11QkB2Y87ktOl+VvZUh+WU/9ax0WPXerxK1GF9DNc=;
 b=bV0z8hXP3SDrV5MgEfdcOc4C3Is/8B9U1KhS3PG3E/DwSZxtRRa9w/CmZxaO32A36+
 c8sIZTyknjpYFJgkJ0HnAoqj95UwtlmbY7GrHEoIKoAf8IUhlIIxxaX0peeUGa/KxVxE
 1U8Jgzxme6RycoycPecN7A/uuTRr+q/UxiTxe7MSmIqBbLAwOey+GvhDVlH+VWt6jF4J
 3/T/bnZrxG8tnkwFxtrE+DOLWlxlrSigFbGeXXSBaH5xrIyKFzPNz/3eGc9mQnplaWKP
 YyBXg9xA0mx6HW4t2sL4O4dqpSbTpTNJl15PCP6LnyQb0lvcWvvwWgq18IWXfTHHPdyX
 SyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779699089; x=1780303889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eF11QkB2Y87ktOl+VvZUh+WU/9ax0WPXerxK1GF9DNc=;
 b=NaLnIrpgxWpoLThMwu8UVkuhHdIx7fFbSrosIcuWKim5JfX6P5dkdPc1j7N0mJGqrw
 B0hc2Gricrlss0cla+Mby7tt/NgAPwNwzLytEQa20ZJ4ruedzLh9/hijfJidduKazdZt
 L4b/cG1/UfjXEpRqFraa7aDmmhL5u6SIg/JlAUw37Njtz85Uq12ODo2wXFs9DJ8PnZst
 1rAHAwj7NS6fqGiyLGXfZ1lUDdEgd/4i8ifzvI9y3d2wECbiPWhPfsK/Hy43R+0NysC4
 IbpktJ6ZTNn668B1QG177YzAV0+lQGKZhUWnhXFhX5yMLMWlHFwjhvMzpYLM7RzTmvAJ
 sbjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XbXtOuid9s6wguZUtpuyuCLAx6wgMwLrCf3h0Kj7hH6wxY+mPP6A7v4oKG6HIEG/9/7x9ajSG/1A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGDT801TF6yOVSyMzObC+GiFaJolqeTryrUKJtqCeQhoVxXtLN
 Vk4sJTu5ynZkjm6ItbO0g04EyS+y82XgeNQhqTqj8TqgNDFEVHys485XggbrRKcyZS8=
X-Gm-Gg: Acq92OFerp86WuaQBOyym5QL3cal92CmMRD9j5xuldUjCASqlG3r4bGRd0c41MrTls6
 j/BIkn++r9EKl1+iv226c3E1YlBLGZGP6YerfahYDC+JEGMNqQs/Q2nUOrq65gvTIf1DaOCNsQV
 j/v0EiJJQiamzW6+W+j4aSB0g6ksZgZQ68+2nUJppx/C5Btb23QTlFsy6PY1R61iJlSwRxlJd2J
 ka83FkWChuBxIS/YzP0XkmCfwTlYsQW/d/qgT8SUMJiZaBAFzH2ct8oHjPGOSu/dmqH/9mM8KF5
 0NajIswQWFKv/n2qd1guVomZ0D48f9RbjlI23vOKc/TjJFKmeTxb/DxCB0Wu7LaG621kSJTrdWc
 ict7tIlbscuprwO2OXZpUpudBfJ1m6mWDEzN0vgJHy9gXrNW26rVDgOIV1s9cdwNOe6UZrgVQCP
 +evQh95O6xlJaT/Ur20GXtT7ASqBy3wWmviGXQyG3V2/zFmBYBhWuSYXUYe3jmZM/nxByB3ETjQ
 W1O2Z0I6VGJICAAsDCL9ViwhR1ahUTQawWylmYktOU8pzU6OHVC
X-Received: by 2002:a05:7022:799:b0:132:2486:acb with SMTP id
 a92af1059eb24-1365f81e585mr4905784c88.12.1779699089379; 
 Mon, 25 May 2026 01:51:29 -0700 (PDT)
Received: from [192.168.30.115] ([186.220.219.33])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a509602sm6080008c88.8.2026.05.25.01.51.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 01:51:28 -0700 (PDT)
Message-ID: <96a6ce62-d015-4cc7-8584-bb73171f23a9@usp.br>
Date: Mon, 25 May 2026 05:51:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
To: Ulisses Paixao <ulissespaixao@usp.br>, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: Felipe Sousa <felipesousa@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260505175006.13519-1-ulissespaixao@usp.br>
Content-Language: en-US, pt-BR
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
In-Reply-To: <20260505175006.13519-1-ulissespaixao@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Ulisses,

On 05/05/2026 14:50, Ulisses Paixao wrote:
>  
> +/**
> + * amdgpu_gfx_handle_priv_fault - Handle privileged instruction fault
> + *
> + * @adev: amdgpu_device pointer
> + * @me_id: micro-engine ID of the faulty ring
> + * @pipe_id: pipe ID of the faulty ring
> + * @queue_id: queue ID of the faulty ring
> + *
> + * This function handles privileged instruction faults by identifying
> + * the faulty ring (gfx or compute) and triggering a scheduler fault.
> + */
> +void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
> +					u8 me_id, u8 pipe_id, u8 queue_id)
> +{
> +	struct amdgpu_ring *ring;
> +	int i;
> +
> +	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +		ring = &adev->gfx.gfx_ring[i];
> +		if (ring->me == me_id && ring->pipe == pipe_id &&
> +		    ring->queue == queue_id) {
> +			drm_sched_fault(&ring->sched);
> +			return;
> +		}
> +	}
> +
> +	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +		ring = &adev->gfx.compute_ring[i];
> +		if (ring->me == me_id && ring->pipe == pipe_id &&
> +		    ring->queue == queue_id)
> +			drm_sched_fault(&ring->sched);
> +	}
> +}
> +
>  
Looks like the same pattern already exists in gfx_v10 as well.

gfx_v8 and gfx_v9 are slightly different though, since they directly
fault gfx_ring[0] for me_id == 0 instead of matching pipe/queue.

Mentioning this in case it’s useful for considering whether the same
cleanup could be applied there as well.

--
Kind regards,
Guilherme Ivo


