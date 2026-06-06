Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642DDCD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 22:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1607210E0E6;
	Sat,  6 Jun 2026 22:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=mail.ru header.i=@mail.ru header.b="vS+quuBr";
	dkim-atps=neutral
X-Greylist: delayed 2398 seconds by postgrey-1.36 at gabe;
 Sat, 06 Jun 2026 22:06:21 UTC
Received: from send104.i.mail.ru (send104.i.mail.ru [89.221.237.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48E1110E0E6
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 22:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 Disposition-Notification-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive:X-Cloud-Ids:
 Disposition-Notification-To; bh=mP89QG16QYZU0XizrgGZUIz9phS/Opn8XfK6Q7AM4uA=; 
 t=1780783580; x=1780873580; b=vS+quuBrLzMMRGZenHRJV2NxQ6szcSRC7rzA8CjBe5BeYlx
 7JWWdOvC/TLSTQl4/Bz63sN8xiM/QdZ0BGUGoGsV4PAeAQRIKVZi1FuDSk0Zmmytl/IqO+hXFrLs9
 +lS8peblS6AHF6A3wlj/Y7zWXAlQ+8xv30VmoCv6xiFl0PHf5ql/dtHUTLXbTqaxOCTqZulvbgvMu
 ILtBfyzwkaIXH1IR1hLiryKJDuIpkwDa8/VNNVDhM/WvZILofSBKfj7Hbcm2J/BM/JKQ1Us0mUlZ3
 iYZj2L4rwUxlB5Pu1jRxKcr8X7cQj8anNy2WksYI8zQyLw+ucSNxHbtTX7bBjf0g==;
Received: by exim-smtp-85dd497b6-lj7c9 with esmtpa (envelope-from
 <listdansp@mail.ru>)
 id 1wVz9m-00000000GwA-0swg; Sun, 07 Jun 2026 01:06:18 +0300
Message-ID: <e11ed4a6-1882-48b8-a177-cac4fce2867c@mail.ru>
Date: Sun, 7 Jun 2026 01:06:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Validate max_fclk_mhz in DML2 policy
 builder
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260606212503.140638-1-listdansp@mail.ru>
 <20260606215013.4D7911F00893@smtp.kernel.org>
From: listdansp <listdansp@mail.ru>
Content-Language: en-US
In-Reply-To: <20260606215013.4D7911F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: exim-smtp-85dd497b6-lj7c9;
 auth=pass smtp.auth=listdansp@mail.ru
 smtp.mailfrom=listdansp@mail.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9FAD06046D747065B958182259921CCB5B28B9DF39DB93621182A05F538085040076D29AEEDE398773DE06ABAFEAF67051133C554DE158315D2EAB06290505A20FB1C19767FBE8657
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE749E89BD568380EECC2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7E50EC9128971FD6EEA1F7E6F0F101C67CDEEF6D7F21E0D1D9295C2E9FA3191EE1B59CA4C82EFA65873317C0A341D396F5D03B9DA6973CF4F92C6DCA76C938DC76F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE701C05ED510F1C3F19FA2833FD35BB23D9E625A9149C048EE1E561CDFBCA1751FF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637028599BB38096F4F389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F79006371F1AC37D75FB230FD81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE77D6028A3C1764613EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3C037C7826540211F35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A593DC10E6B315826C5002B1117B3ED696BE5DA32377FB1237466072E6821086B3823CB91A9FED034534781492E4B8EEADAEB4DDBFD72C8FA1BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F9677DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659CA01EDCBFC2A01711775A4B5452EA00C4FE2F30E5354A76FDAA771D5992AD3ADF033D13590098C1EB8341EE9D5BE9A0A2E4ED0D8C06E0207BFBB9232BE12446F24E0AB79442228E08CD93680B12512CF4C41F94D744909CE04437D853D7CD20871FE3B1D98EC473624A389F0E278DBF4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVRI2994ruhLUnp1S62S4+bo=
X-Mailru-Sender: 4CE1109FD677D277A25EA9D9B320DF534407A02A58CC0C4EB951B70A5BD4BD8EA28D906F4547E408E3F52FC5FCA1AAF6C53BD13D3F6EEB2F3DDE9B364B0DF289C95E31D8FCF52BE1594FB4C9F0DBF4120D4ABDE8C577C2ED
X-Mras: Ok
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

On 07/06/2026 00:50, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing bounds check in `insert_entry_into_table_sorted` allows array out-of-bounds write.
> --
> 
> commit 803110810943a93ffdbd8a40adba9348d5b58b1b
> Author: Danila Chernetsov <listdansp@mail.ru>
> 
> drm/amd/display: Validate max_fclk_mhz in DML2 policy builder
> 
> This commit adds a validation check for max_fclk_mhz to prevent an integer
> underflow and out-of-bounds array access when all FCLK entries are zero.
> 
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c
>> index ab2964811c5bc..938faa6272c2c 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c
>> @@ -157,7 +157,8 @@ int dml2_policy_build_synthetic_soc_states(struct dml2_policy_build_synthetic_so
>>   			num_uclk_dpms++;
>>   	}
>>   
>> -	if (!max_dcfclk_mhz || !max_dispclk_mhz || !max_dppclk_mhz || !max_phyclk_mhz || !max_dtbclk_mhz)
>> +	if (!max_dcfclk_mhz || !max_dispclk_mhz || !max_dppclk_mhz || !max_phyclk_mhz ||
>> +		!max_dtbclk_mhz || !max_fclk_mhz)
>>   		return -1;
>>   
>>   	p->out_states->num_states = 0;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can the subsequent state
> insertions overflow the out_states array?
> 
> Looking at dml2_policy_build_synthetic_soc_states(), it calls
> insert_entry_into_table_sorted() multiple times:
> 
>      // Insert all the DCFCLK STAs first
>      for (i = 0; i < p->num_dcfclk_stas; i++) {
>          ...
>          insert_entry_into_table_sorted(p->in_bbox, p->out_states, &s->entry);
>      }
> 
>      // Insert the UCLK DPMS
>      for (i = 0; i < num_uclk_dpms; i++) {
>          ...
>          insert_entry_into_table_sorted(p->in_bbox, p->out_states, &s->entry);
>      }
> 
>      // Insert FCLK DPMs (if present)
>      if (num_fclk_dpms > 2) {
>          for (i = 0; i < num_fclk_dpms; i++) {
>              ...
>              insert_entry_into_table_sorted(p->in_bbox, p->out_states, &s->entry);
>          }
>      }
> 
> If num_uclk_dpms and num_fclk_dpms can each be derived from the 30-element
> input array, the combined insertions could exceed __DML_MAX_STATE_ARRAY_SIZE__.
> 
> Inside insert_entry_into_table_sorted(), elements are shifted without a bounds
> check:
> 
>      for (i = table->num_states; i > index; i--) {
>          table->state_array[i] = table->state_array[i - 1];
>      }
>      ...
>      table->num_states++;
> 
> Could this write past the end of table->state_array if the total number of
> inserted states across these loops exceeds 30?
> 

Thanks for the review. Both reported issues are pre-existing in the codebase and are completely unrelated to my changes. 
This patch does not introduce, touch, or modify this logic. I request the maintainers to review my patch as is.

Best regards,
Danila Chernetsov
