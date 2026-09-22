Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1230FC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD5510E42C;
	Tue, 22 Sep 2026 08:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="YJp1MjoR";
	dkim-atps=neutral
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch
 [185.70.43.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187A110E42C
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail2; t=1790067040; x=1790326240;
 bh=E9NNd/hqIo8h2Ae3BVu7MmGQh7O49JFHokGLTTnK7vI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=YJp1MjoRNPPRgAwoDey61j7Tk7iOXvFdgrIAqisfsLJlSfdQ3M73MN0hiSPliLZLl
 x97UT5usS4+82v2KvPvPVoRV/Z/ppuv7r4Xpi2Ywg99v6A8l2ayTfvH9+ApmJroxmW
 r57QVUc6643QnFWNuuR/LOb5fzXn8rMQmU23e5ezTa0h3gT9QRdRspMwLHo0/VA0Yq
 S/wzC/ccTpR2Nmlz4ZlFHGBeRERW1bpRT0LjZW0LJ1qjCnn1btuX4WEnp+U5Df7dZP
 6/ZIZ3WVP4ezTFrOfg2qFagqa96iYHv06bA6WFS91QyAkYHSzWNW0mcMaDmp2k3E5j
 y6kuB/ePWcLoA==
X-Pm-Submission-Id: 4hpv235Vj3z2ScdY
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH] rust: DmaFence: Remove static lifetime
Date: Tue, 22 Sep 2026 11:50:32 +0300
Message-ID: <20260922085033.57008-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260922083631.444614-2-phasta@kernel.org>
References: <20260922083631.444614-2-phasta@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 22 Sep 2026 10:36:32 +0200=0D
Philipp Stanner <phasta@kernel.org> wrote:=0D
=0D
> A FenceCallbackRegistration can stem from another party than the one=0D
> that has created a Fence. Should that party forget the registration=0D
> object (for example through a refcount cycle) and then unload the=0D
> module, a fence signaling would run into the unloaded module, causing=0D
> UAF bugs.=0D
> =0D
> So far, this has been solved by demanding that the payload data of the=0D
> registration object demanding static lifetime.=0D
> =0D
> It turns out, however, that this is harmful because the static lifetime=0D
> bubbles up to all users, ultimately potentially causing a large amount=0D
> of driver data to be static, which renders the lifetime obsolete.=0D
> =0D
> Solve this issue instead through an unsafe requirement which demands=0D
> that the user does not forget the registration object. This is also the=0D
> solution chosen by ScopedWork.=0D
=0D
Makes sense.=0D
=0D
Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
=0D
> =0D
> Suggested-by: Danilo Krummrich <dakr@kernel.org>=0D
> Signed-off-by: Philipp Stanner <phasta@kernel.org>=0D
> ---=0D
>  rust/kernel/dma_buf/dma_fence.rs | 16 ++++++++++++----=0D
>  1 file changed, 12 insertions(+), 4 deletions(-)=0D
> =0D
> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs=0D
> index 18a43e1bb442..c3fa68c4df86 100644=0D
> --- a/rust/kernel/dma_buf/dma_fence.rs=0D
> +++ b/rust/kernel/dma_buf/dma_fence.rs=0D
> @@ -291,7 +291,7 @@ fn from(e: AllocError) -> Self {=0D
>  ///     }=0D
>  /// }=0D
>  /// ```=0D
> -pub trait FenceCallback: Send + 'static {=0D
> +pub trait FenceCallback: Send {=0D
>      /// Called when the fence is signaled.=0D
>      ///=0D
>      /// This is called from the fence signaling path, which may be in in=
terrupt=0D
> @@ -310,7 +310,7 @@ pub trait FenceCallback: Send + 'static {=0D
>  /// When this object is dropped, the callback is automatically removed i=
f it=0D
>  /// hasn't been called yet.=0D
>  #[pin_data(PinnedDrop)]=0D
> -pub struct FenceCallbackRegistration<T: FenceCallback + 'static> {=0D
> +pub struct FenceCallbackRegistration<T: FenceCallback> {=0D
>      #[pin]=0D
>      callback_foreign: Opaque<bindings::dma_fence_cb>,=0D
>      callback: ManuallyDrop<T>,=0D
> @@ -326,7 +326,14 @@ impl<T: FenceCallback> FenceCallbackRegistration<T> =
{=0D
>      /// On success the callback is pinned in place and will fire when th=
e fence=0D
>      /// signals. On `AlreadySignaled` the callback is returned to the ca=
ller so=0D
>      /// that owned resources can be reclaimed.=0D
> -    pub fn new<'a>(fence: &'a Fence, callback: T) -> impl PinInit<Self, =
CallbackError<T>> + 'a=0D
> +    ///=0D
> +    /// # Safety=0D
> +    ///=0D
> +    /// `callback` must not be forgotten.=0D
> +    pub unsafe fn new<'a>(=0D
> +        fence: &'a Fence,=0D
> +        callback: T,=0D
> +    ) -> impl PinInit<Self, CallbackError<T>> + 'a=0D
>      where=0D
>          T: 'a,=0D
>      {=0D
> @@ -693,7 +700,8 @@ struct DriverFenceData<'a, T: Send + Sync + FenceCont=
extOps> {=0D
>  ///=0D
>  /// let cb_data =3D CallbackData { };=0D
>  /// let waiting_fence =3D ARef::from(fence.as_fence());=0D
> -/// let cb_reg =3D FenceCallbackRegistration::new(&waiting_fence, cb_dat=
a);=0D
> +/// // SAFETY: `cb_data`'s content is not forgotten.=0D
> +/// let cb_reg =3D unsafe { FenceCallbackRegistration::new(&waiting_fenc=
e, cb_data) };=0D
>  /// let cb_reg =3D KBox::pin_init(cb_reg, GFP_KERNEL)?;=0D
>  ///=0D
>  /// // TODO signalling guards=0D
> -- =0D
> 2.55.0=0D
> =0D
