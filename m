Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F362606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=medichon.fr header.i=@medichon.fr header.a=rsa-sha256 header.s=ovhmo3801317-selector1 header.b=JhhVFO7V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDAB810F312;
	Tue, 20 Oct 2026 07:36:43 +0000 (UTC)
X-Greylist: delayed 16800 seconds by postgrey-1.36 at gabe;
 Mon, 19 Oct 2026 13:52:36 UTC
Received: from 14.mo581.mail-out.ovh.net (14.mo581.mail-out.ovh.net
 [178.33.251.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C98810E17A
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:52:36 +0000 (UTC)
Received: from director11.ghost.mail-out.ovh.net (unknown [10.110.43.142])
 by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4j7SVt0hCVz5x0f
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:54:29 +0000 (UTC)
Received: from ghost-submission-7ccd8bbbb6-w2p87 (unknown [10.108.42.201])
 by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id A6EAAC3DDE;
 Mon, 19 Oct 2026 07:54:27 +0000 (UTC)
Received: from medichon.fr ([37.59.142.109])
 by ghost-submission-7ccd8bbbb6-w2p87 with ESMTPSA
 id VzFGHbPM1Wq57gYAh9bqlA
 (envelope-from <abo@medichon.fr>); Mon, 19 Oct 2026 07:54:27 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003e25b5ac9-02cb-4e08-a646-4f4adac193de,
 E22553FEB6AEB75B33DDF2A505A99149E93FA69D) smtp.auth=abo@medichon.fr
X-OVh-ClientIp: 88.190.90.129
Message-ID: <fd9c0bbe-6e0c-486a-ad23-ea99935a28ce@medichon.fr>
Date: Mon, 19 Oct 2026 09:54:27 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Arnaud Bonnet <abo@medichon.fr>
Subject: Re: [PATCH v2] drm/amd/display: remove unused cgs register accessor
 typedefs
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, paulmck@kernel.org, rostedt@goodmis.org, ast@kernel.org,
 peterz@infradead.org, gregkh@linuxfoundation.org, skhan@linuxfoundation.org
References: <981f01e1-0c3b-4854-9d72-8bf22af9fc64@amd.com>
 <20261017130047.42080-1-emmaonana18@gmail.com>
Content-Language: en-US, fr
In-Reply-To: <20261017130047.42080-1-emmaonana18@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 14750696155911184108
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFZwibN2X4LhiJ8W0tUYc5FALRBUgdsXp4Cvwtq5HmBNTJ/DhmOsjLVRLwnvo45p0o3UE2/FwOEIOL0ls83wAjFlTbu3rRMyKHEGGMyy3noj+1xxDlTsbUf4s3TD+Cr6QtaxcaHl8NcaWKKlq5Cc0p1tM75VF21hHAc0wHOHfUBBknrSCUKQsWr8SfgQwUdZdH6sBBYYKnRR1pgARI5gcdJ3+OaqRXsyY5f+UQHLc4gHkPKRyf4MfvpDXOEkdPuLELSpCOHDiEsjUPw0loF9KWlktWvUPs8YKr9vhioEiG0yTQcjgRnnvzf30Q/OKQWfzJqoJVD4m/kqpBLe1gu/HGLk3dhDxVpbX1eJQCNbJrpV2MR9J0rRZwBNWuAqkX7DyWfQPXi+CQOkq1kxrWASpDQKEm7uxIGIgYFp9agWgoxdi+SOtO6W/n7x1y+9sLrruU1uQOXW4vWOOvPBbcA0Um5IlVt7s5kPBmrGbYvLYGjiJvY2+rvSEr22T2thjAkBKadBbK71+PF9I3T1qhTJNu0GvWUVgfPk2dwgsGM9ilL9jYTtGZLgU3MMnzXU0Q+fzsVj0WV4vl3LKVobRvDA3PkdGG6b9NfrmVk3RDA4XjaLvpQ31C+XMFt3qKmMRxQ1AOOo+0dAx83yts65W6n42rzpWqq/0GHOvV9L0f8sBLnjQ
DKIM-Signature: a=rsa-sha256; bh=gTmA+d0ikT+8IflEYztNYyZ9CNFtEwNKlyOUdD5euEE=; 
 c=relaxed/relaxed; d=medichon.fr; h=From;
 s=ovhmo3801317-selector1; t=1792396470; v=1;
 b=JhhVFO7VDlltUMNaBs5QxNf4mDuYlXJgSzv2iPVhIse9XoiWK3azQ5proojZ3M4z/CBRCEG1
 m/mrFcnqi/01zSrT0zj0xai+loshbS955gCT+Ktrk2QsRtkyYj0BLu9ctPMxcuf2nUwfLj/YC9B
 S0gbwT/AcuG60zA1KR5RhCYFiggbPVvnG/ZBf8p8ll6pLcbf+TBn4PV5wzrg93HeZfxd8xgPO7U
 6QQMhblNcTGmS6MqvQTqZhHnI94RLVqRTs/Bx4270JaB0q0/9E9FZPgMrxYScfm2Fn/9so/EskF
 Rkk2+8Yw0Wj9Xsxo/E8IdnC4Qo/5AKzDgdff9PNQ3eD8Q==
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/17/26 3:00 PM, Omokefe Emmanuel Onanaroghene wrote:
> kernel-doc reports prototype mismatches for the cgs register accessor
> typedefs, e.g.:
> 
>   drivers/gpu/drm/amd/include/cgs_common.h:89: expecting prototype
>   for cgs_read_register(). Prototype was for uint32_t() instead
> 
> Each of the four typedefs is used exactly once, as
> the type of a struct cgs_ops member, so they are merely an
> unnecessary layer of indirection. Drop the typedefs along with their
> kernel-doc comments and write the function pointer types directly in
> struct cgs_ops.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Link: https://lore.kernel.org/all/981f01e1-0c3b-4854-9d72-8bf22af9fc64@amd.com/
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
> ---
>  drivers/gpu/drm/amd/include/cgs_common.h | 60 +++++++-----------------
>  1 file changed, 18 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/cgs_common.h b/drivers/gpu/drm/amd/include/cgs_common.h
> index f40b6a03fe63..1750401c7d08 100644
> --- a/drivers/gpu/drm/amd/include/cgs_common.h
> +++ b/drivers/gpu/drm/amd/include/cgs_common.h
> @@ -80,43 +80,6 @@ struct cgs_firmware_info {
>  
>  typedef unsigned long cgs_handle_t;
>  
> -/**
> - * cgs_read_register() - Read an MMIO register
> - * @cgs_device:	opaque device handle
> - * @offset:	register offset
> - *
> - * Return:  register value
> - */
> -typedef uint32_t (*cgs_read_register_t)(struct cgs_device *cgs_device, unsigned offset);
> -
> -/**
> - * cgs_write_register() - Write an MMIO register
> - * @cgs_device:	opaque device handle
> - * @offset:	register offset
> - * @value:	register value
> - */
> -typedef void (*cgs_write_register_t)(struct cgs_device *cgs_device, unsigned offset,
> -				     uint32_t value);
> -
> -/**
> - * cgs_read_ind_register() - Read an indirect register
> - * @cgs_device:	opaque device handle
> - * @offset:	register offset
> - *
> - * Return:  register value
> - */
> -typedef uint32_t (*cgs_read_ind_register_t)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
> -					    unsigned index);
> -
> -/**
> - * cgs_write_ind_register() - Write an indirect register
> - * @cgs_device:	opaque device handle
> - * @offset:	register offset
> - * @value:	register value
> - */
> -typedef void (*cgs_write_ind_register_t)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
> -					 unsigned index, uint32_t value);
> -
>  #define CGS_REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
>  #define CGS_REG_FIELD_MASK(reg, field) reg##__##field##_MASK
>  
> @@ -137,14 +100,27 @@ typedef int (*cgs_get_firmware_info)(struct cgs_device *cgs_device,
>  				     enum cgs_ucode_id type,
>  				     struct cgs_firmware_info *info);

Hi Omokefe, you probably forgot
-typedef unsigned long cgs_handle_t;
-typedef int (*cgs_get_firmware_info)(struct cgs_device *cgs_device,
-                                    enum cgs_ucode_id type,
-                                    struct cgs_firmware_info *info);

As discussed I have built and ran some IGT on hardware for the versions
with and without these two, so you can still use the tag if you send v3:

Tested-by: Arnaud Bonnet <abo@medichon.fr>

>  
> +/**
> + * struct cgs_ops - Common Graphics Services operations
> + * @read_register: read register value
> + * @write_register: write register value
> + * @read_ind_register: read indirect register value
> + * @write_ind_register: write indirect register value
> + * @get_firmware_info: get firmware information
> + */
>  struct cgs_ops {
>  	/* MMIO access */
> -	cgs_read_register_t read_register;
> -	cgs_write_register_t write_register;
> -	cgs_read_ind_register_t read_ind_register;
> -	cgs_write_ind_register_t write_ind_register;
> +	uint32_t (*read_register)(struct cgs_device *cgs_device, unsigned int offset);
> +	void (*write_register)(struct cgs_device *cgs_device, unsigned int offset,
> +			       uint32_t value);
> +	uint32_t (*read_ind_register)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
> +				      unsigned int index);
> +	void (*write_ind_register)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
> +				   unsigned int index, uint32_t value);
>  	/* Firmware Info */
> -	cgs_get_firmware_info get_firmware_info;
> +	int (*get_firmware_info)(struct cgs_device *cgs_device,
> +				 enum cgs_ucode_id type,
> +				 struct cgs_firmware_info *info);
>  };
>  
>  struct cgs_os_ops; /* To be define in OS-specific CGS header */

