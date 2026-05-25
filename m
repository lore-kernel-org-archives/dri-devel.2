Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7475ECD4F54
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 03:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6F210E12B;
	Mon, 25 May 2026 03:09:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="tjbWDc82";
	dkim-atps=neutral
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB7310E12B
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 03:09:22 +0000 (UTC)
Message-ID: <dd9e2238-5c65-48e5-914a-8b8eb3b02fc5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1779678559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SlU8w8oKZ/LRXeF8t+ePaNHx0/5MGTXhf0IhGMIH1/Q=;
 b=tjbWDc820Umpe+uqfHT/77GhuHkjhWxXIV37u/to6fGcY7l45lZGZGwGe5D4PJRc+hhQCL
 ql2r9Gl1u22SD1CRJXkI5zXgbcIQc3u0dCUKm9cb1YwgFFdSeuTYrbjZWsdN3EdD9QmOsc
 y3DGvepCpPSRhlc6dQZTLViSA7afXu0=
Date: Mon, 25 May 2026 11:08:53 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 11/13] drm/tyr: add debugfs infrastructure
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260326-b4-tyr-debugfs-v1-0-074badd18716@linux.dev>
 <20260326-b4-tyr-debugfs-v1-11-074badd18716@linux.dev>
 <DILPYDI01YFS.2NPFG6ZG085PP@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <DILPYDI01YFS.2NPFG6ZG085PP@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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


On 5/18/26 18:09, Danilo Krummrich wrote:
> On Thu Mar 26, 2026 at 7:53 AM CET, Alvin Sun wrote:
>> +#[pin_data]
>> +struct TyrModule {
>> +    _debugfs_root: HazPtrRevokeHandle<'static, kernel::debugfs::Dir>,
>> +    #[pin]
>> +    _driver: Registration<platform::Adapter<TyrPlatformDriverData>>,
>> +}
>> +
>> +impl InPlaceModule for TyrModule {
>> +    fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, error::Error> {
>> +        let dir = kernel::debugfs::Dir::new(kernel::c_str!("tyr"));
> Why does Tyr need its own debugfs directory to expose DRM data structures? DRM
> already has a common debugfs directory per DRM device in /sys/kernel/debug/dri/,
> which you should attach to instead if you want to expose driver specific files.

Hi Danilo,

Sorry for the late reply, I was busy with the fops owner patch series
  last week.

Thank you for the detailed review and suggestions. I've reworked the
implementation based on your feedback:

- Instead of creating a separate tyr debugfs directory, the code
   now hooks into the DRM core's per-device debugfs root under
   /sys/kernel/debug/dri/ via a debugfs_init callback.
- The duplicated show_vm() code is eliminated — the gpuvas file now
   reuses the existing drm_debugfs_gpuva_info() through a safe Rust
   wrapper, rather than re-implementing the VA space dump.

Note that the GEM debugfs interface is not yet implemented — I'd like
to get your feedback on the overall approach first before continuing
with that part.

Please review the updated series [1] and let me know your thoughts.

[1] 
https://gitlab.freedesktop.org/alvinsun039/linux/-/commits/tyr-debugfs-v2

Best regards,
Alvin

