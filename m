Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8875C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 133C210E62D;
	Wed,  8 Jul 2026 16:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Kaa1jvF0";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011033.outbound.protection.outlook.com [52.101.125.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C6610E62D
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUpD+J6TD2nqwJb0YhbDuyxAgXomign5wZrAhibr+EYumdZySrUbGX/I5tfJtFEPezrYWAXbeZ8uYcLd8KB3zMqeqiaXOwS8AP8bmRWJAv4fW2AUR+wNrYx2zv3zMSd36RDVlp/h+gxZcLrHjiMRBb6YGgFp/M09jg9JIZ/Wx0o2hQf51xUv79h1c827qEhZ+gqPzbRSSlrPA583akB8Ocbe9VzXU6GSj/azG2+PfEeTF893twqAAZQn4rP03e0jxjhbBG+mKw7Q9q1deq3GNytBbXMBsP8KHJVBNTnzZeoP8vCmTCqPw4xudn5lYJFHRcSt4Sx39evkI2tILnWvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiY3IS3wny8UxwCTbz5a71itRgtuHpCMkTZtBG5c8pM=;
 b=GjU9IRyZS8nxIZgBkv9VOP88YtJyO5VCpR2J9xOWnpvf8U96q6UG8rRRCs6zImhBAa1Lfwrmyt8BFr53U4+Qsa+9pjYdG87SxR2qFf8D8AeZTn+pjGs12Srt0YJut2tIlYXdBTe93z/LdwQ80KCYVVBnzcsLPDpjwafW/51zoBt7CE/w7w6TJuAruY+jpYCkat1yMGj/Qn3KFsP0UEYXeJRlUVIBNaBOxy388tGincO5kupdnMwqThxoNE2mKMjqkkV/rXqYIkkHMlPYMsTu2C9T9czloA3wKCG2Q2hm44M/DxFHWpfZsItQ2ftiziu9WAT5pITwIdMh5dCS7U6Jog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiY3IS3wny8UxwCTbz5a71itRgtuHpCMkTZtBG5c8pM=;
 b=Kaa1jvF03nqLSxd6Z12VdA3xrmnj82W+KZTPRt8jXUqZOHdlqAgUlTFWWIvwwDebsJavHgtoHrqswXh1wOu1hHuuaWUIsAUeJfWe1p35BJkaYH/xfMZLE5Ff8KN8arjxAXp+EH5jvSVCJmbgdfW0I4ZGaZgkneLaEFu+nc+w/Dc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS7PR01MB14587.jpnprd01.prod.outlook.com (2603:1096:604:38d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 16:46:04 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 16:45:58 +0000
Date: Wed, 8 Jul 2026 18:45:40 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 07/16] dt-bindings: display: renesas,rzg2l-du: Document
 RZ/G3L SoC
Message-ID: <ak5-tIYnLmHps4M4@tom-desktop>
References: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
 <20260704093433.273672-8-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704093433.273672-8-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS7PR01MB14587:EE_
X-MS-Office365-Filtering-Correlation-Id: 05eff522-a4ef-4b62-b756-08dedd1062c7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|52116014|18002099003|38350700014|22082099003|4143699003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: VYIyrrexNDeF2MgQpkZCcrgpRf2K1Etd2KpeXT61Aa4ceKy88C/g1eJSO4VllvdZM6Kk+KUuUq7EcHQFcpepgKk5tLFJ9He18WIXK1uZwQS7cW2IdfJ4gPzPPNPq/Gu3CdNpZu+zYWYflNJTnfkTGzAPZqkJ69lGZxJEQiQ01GVOZ2V0zkTIO9sHUZnAAioaFsv2SJiqttWVNe8wWUux8lipEjFrp8YPX9M+s36rfDSfaKUnFjlxsC7LhTNICm7Cy1s6YrmIxymbPpp07PO0eegIAx7zptsvaAA1AIP9vinXPQD0d4MtTrrzRnmuY0Vtfl7w4tshXX9CVIjyQ4PE9fGgFfbUuvlS7hLvIkFbuQ86Ya4nsox2XSSKiC9v6+FBErJHNpMQONoI6HGndE0yx0MJ3GfJ4mUkvJlVY7sjkssjrFrl9/ACV4zYrp8QaoYHV/LgHdTyMCM56u6HUX/Rjm2ozYGbJkUO12/ezZ6vnHGlE5w6ZCsY9LDVVWaV24+siLQgUgpVsASOZywPC9Kqglb9qSipPD8vZikODT1FXpWTv/9CE62VjDC8NxinVYgJwGPj9JWQyuwzKKioO01JSHE22mBBlm9VaOn0moW864fiZDvy8hWZ7g+LUe++dI9MrJxbYFXXydjhVbSCO5sCRpHrcdtx4vXrGXn2PvfMRM3NtfD4FS59GCJE9VaUrUBemrUP4ViZ773LD+DQpaRcmBTPs2kjGVlN+4Tanes8b3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(52116014)(18002099003)(38350700014)(22082099003)(4143699003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GdD1oMva/AjrGRudtODv6u+pjGYyi/lvsej72aTrNK1ixLlfpsckPQkCHoNN?=
 =?us-ascii?Q?nh4k7q/D4Jg/49Kao38z2HHKGEvaC53Xo49oHCtENPdaAd+OQ4ejJ8K5uawJ?=
 =?us-ascii?Q?HUlCV38TLEVnBouSNgF+W6iB25nCSL4Q7dJLf9Fe9Nn1HALgfdUpDC/26xBH?=
 =?us-ascii?Q?qfmn4ER20Sh+ZCWOyXuYkj1YuCNyWL5206ieAhhu9QFRzgCQFC5l+JF6Kd+A?=
 =?us-ascii?Q?FYDXq1JIvAKFW5mKkDQmu1/+R2xwSw+OBAfIPGinxySDZpj2RMBnPDmryqEU?=
 =?us-ascii?Q?A60WPLSPKfhp6HACYp1sMfhfu0oQQ90mr49Xb+sadNhb1uq94CIraYopT2dC?=
 =?us-ascii?Q?l2II74zevdGW66SQW5vyS4Wsa6kwoB4G476rw9dtKsheWnKa5eAmBPbfx5aT?=
 =?us-ascii?Q?suwWIB4Kr9Wq76GqmJB6WDEJCmHGhJgflY77Fwv3ZaU4eZJaHShxAE2lwt4Z?=
 =?us-ascii?Q?rBOZjZbxVY2a/ER3dbCMsFbt8brcUq7avwzV0TsCjJ11ceM55AOXl9Y1VKro?=
 =?us-ascii?Q?NNb/Vik4g/H/vfsmTKyLYrXCjZYwXAGiCe+36/Kgo0NurylosVBrsPKSMlpU?=
 =?us-ascii?Q?dugJ50ibOmIUrISxCt7A7GTfta1vQdXmShMlVrKqqCNwa2NXseo1PqQcTRJV?=
 =?us-ascii?Q?qI0hiLzlVu3jna9NWr+fNB7J+/3GyxhcYvqKpocOasSKrXy7Zo7pPoVysgFR?=
 =?us-ascii?Q?DPiz5XZj/rcPHFQ9xR0w0QkbkLrAe+cm9u9EeEwuKVF6fbhNX3SwTxzVol/l?=
 =?us-ascii?Q?rq40jAb66B20IxJP4jKRrxvPpX/SvcLgXeJ/eFaXNMRgMsjCd6v0XYyouQuO?=
 =?us-ascii?Q?66A2MOcmf7BfDiQohOFdMWM6/mwKVf7sQBNN9O18LqdZ5CoSPzBtNUTWnlK3?=
 =?us-ascii?Q?BQDSs6It5Vkne2wUsTDn58IXyVtDtU7iZeCZ269VxM3k5iSXhXNWd4L95SOY?=
 =?us-ascii?Q?9bbXhq61aUZFGY1a7m02TTYSUwZn5e8qrPPW5bEsOWCnm+cGfmm93mJqfmxP?=
 =?us-ascii?Q?+JIWyCG/ckpI4HuNYQmPPA6QlRd/BlISIflwWm4eDiMlT9e3Todxe19EQsYG?=
 =?us-ascii?Q?KHFVdXGMqjT1cSZ/aA2EkeL3cncAG0On2j0q/O4D1AfqLfiP1uFq1Exu7J8s?=
 =?us-ascii?Q?IqBYrrnCttQ8yAycVh10JKW0XRAb1cZjixLmPJPftLGtlJXoGtgG0tc1siVy?=
 =?us-ascii?Q?+QAg352RikLU7EA4msQCDwCC6l/959NJSEvX16pyAnRgI3AtnEcQW3FPuMPF?=
 =?us-ascii?Q?m74gdn/YV7qy+FHEyBygOnsDVQ7+OajfUTBmhbn4Lp0NmybHTVxQovKqwFZO?=
 =?us-ascii?Q?T17ZDm1Hr6k4loi5JfEUnnApDIoTkZFxTUsqOCiHtjiLV2lXzHcg1ekw2H/3?=
 =?us-ascii?Q?yqyyz6XTqFk4vKbEzAsxHXeghwbATk/ykfwc2b4+nDu8hErZCR/EP52KRYnE?=
 =?us-ascii?Q?nyzf6KvQSEjoPeSzc2s4b4kJZea0pzTfe6+DtB7VejBcKsNUKPA1qIXBGzQJ?=
 =?us-ascii?Q?1N1knl5vQLbpn5kzi5wE07Q/7zRTEDHZnJoZa9VwdROt0OIpjWDT8NrFcRUl?=
 =?us-ascii?Q?mRpJYZNm7i1vBjpGdKHwTDzh88vmogaLpBkF3meIgrFS/iihNRtNOzaDPGh7?=
 =?us-ascii?Q?0b0VFJuIX6UsNfO3H8FR0fPiIMo31AcHYAB3p/GWzJvnrzHN22ROUbAAKwE9?=
 =?us-ascii?Q?t0eluBayYfyv05cw6wvRsKHvD6f3BUc95MAAbAxoYslecfzZFllO9yKGOn2/?=
 =?us-ascii?Q?JuvrKGqSa4TTbzQ6vVPoH+sAJdKqvxnXXl+IuNBLOFGQRcJ+vLLb?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05eff522-a4ef-4b62-b756-08dedd1062c7
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 16:45:58.3264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hkSfPMfhyzzAxo7wUHfgLut1LUKM2F9Tlb5gyFtXBGRH081jpwc3kTekK2jHzpKQplEXc9MD1/q6dg5y9xunnCnHo2HulyTcE3+UjFaHoDbOqDsCCsqa50YM/gHE71B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14587
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

Hi Biju,
Thanks for your patch.

On Sat, Jul 04, 2026 at 10:34:17AM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> The DU block on the RZ/G3L SoC is identical to the one found on the RZ/G2L
> SoC. However, it supports the DSI, DPI, and LVDS interfaces, while the
> RZ/G2L supports only the DSI and DPI interfaces.
> 
> Due to this difference, a SoC-specific compatible string,
> 'renesas,r9a08g046-du', is added for the RZ/G3L SoC.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../bindings/display/renesas,rzg2l-du.yaml    | 27 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> index 7c84a9ecc7a7..65368649fe77 100644
> --- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> +++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> @@ -20,6 +20,7 @@ properties:
>        - enum:
>            - renesas,r9a07g043u-du # RZ/G2UL
>            - renesas,r9a07g044-du # RZ/G2{L,LC}
> +          - renesas,r9a08g046-du # RZ/G3L
>            - renesas,r9a09g057-du # RZ/V2H(P)
>            - renesas,r9a09g077-du # RZ/T2H
>        - items:
> @@ -65,7 +66,7 @@ properties:
>        model-dependent. Each port shall have a single endpoint.
>  
>      patternProperties:
> -      "^port@[0-1]$":
> +      "^port@[0-2]$":
>          $ref: /schemas/graph.yaml#/properties/port
>          unevaluatedProperties: false
>  
> @@ -88,7 +89,6 @@ required:
>    - clocks
>    - clock-names
>    - power-domains
> -  - ports
>    - renesas,vsps
>  
>  additionalProperties: false
> @@ -108,6 +108,7 @@ allOf:
>              port@0:
>                description: DPI
>              port@1: false
> +            port@2: false
>  
>            required:
>              - port@0
> @@ -124,10 +125,31 @@ allOf:
>                description: DSI
>              port@1:
>                description: DPI
> +            port@2: false
>  
>            required:
>              - port@0
>              - port@1
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a08g046-du
> +    then:
> +      properties:
> +        port:
> +          properties:
> +            endpoint@0:
> +              description: DSI
> +            endpoint@1:
> +              description: DPI
> +            endpoint@2:
> +              description: LVDS

I'm seeing you are using ports + port@{0,1,2} in driver and soc .dtsi
so I think here we will need to have ports + port@{0,1,2} aswell.

Kind Regards,
Tommaso

> +
> +          required:
> +            - port@0
> +            - port@1
> +            - port@2
>    - if:
>        properties:
>          compatible:
> @@ -140,6 +162,7 @@ allOf:
>              port@0:
>                description: DSI
>              port@1: false
> +            port@2: false
>  
>            required:
>              - port@0
> -- 
> 2.43.0
> 
